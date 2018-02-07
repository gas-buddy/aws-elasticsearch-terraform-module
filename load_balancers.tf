resource "aws_elb" "masters" {
  name = "${var.cluster_name}"
  subnets = ["${values(var.subnet_ids)}"]

  listener {
    instance_port = 9200
    instance_protocol = "tcp"
    lb_port = 9200
    lb_protocol = "tcp"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 6
    timeout = 5
    target = "TCP:9200"
    interval = 10
  }

  internal = true
  security_groups = ["${aws_security_group.masters_elb.id}"]

  instances = [
    "${aws_instance.master_a.id}",
    "${aws_instance.master_b.id}",
    "${aws_spot_instance_request.master_c.spot_instance_id}"
  ]
}

resource "aws_security_group" "masters_elb" {
  name = "masters_${var.cluster_name}_elb"
  description = "Elasticsearch ${var.cluster_name} ELB group"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "masters_${var.cluster_name}_elb"
  }
}
# Used Defined Ingress Groups
resource "aws_security_group_rule" "masters_elb_user_groups_9200" {
  count = "${length(var.source_security_group_ids)}"

  security_group_id = "${aws_security_group.masters_elb.id}"
  source_security_group_id = "${element(var.source_security_group_ids, count.index)}"
  type = "ingress"
  protocol = "tcp"
  from_port = 9200
  to_port = 9200
}

# Used Defined Ingress CIDRs
resource "aws_security_group_rule" "masters_elb_user_cidrs_9200" {
  count = "${length(var.source_cidrs) > 0 ? 1: 0}"

  security_group_id = "${aws_security_group.masters_elb.id}"
  cidr_blocks = ["${var.source_cidrs}"]
  type = "ingress"
  protocol = "tcp"
  from_port = 9200
  to_port = 9200
}

resource "aws_security_group_rule" "masters_elb_egress" {
  security_group_id = "${aws_security_group.masters_elb.id}"

  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
