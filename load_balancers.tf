resource "aws_elb" "this" {
  name    = var.cluster_name
  subnets = values(var.subnet_ids)

  listener {
    instance_port     = 9200
    instance_protocol = "tcp"
    lb_port           = 9200
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 6
    timeout             = 5
    target              = "TCP:9200"
    interval            = 10
  }

  internal        = true
  security_groups = [aws_security_group.elb.id]

  instances = flatten([
    aws_instance.data_a.*.id,
    aws_instance.data_b.*.id,
    aws_instance.data_c.*.id,
  ])
}

resource "aws_security_group" "elb" {
  name        = "${var.cluster_name}_elb"
  description = "Elasticsearch ${var.cluster_name} ELB group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.cluster_name}_elb"
  }
}

# Used Defined Ingress Groups
resource "aws_security_group_rule" "elb_user_groups_9200" {
  count = length(var.source_security_group_ids)

  security_group_id        = aws_security_group.elb.id
  source_security_group_id = element(var.source_security_group_ids, count.index)
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 9200
  to_port                  = 9200
}

# Used Defined Ingress CIDRs
resource "aws_security_group_rule" "elb_user_cidrs_9200" {
  count = length(var.source_cidrs) > 0 ? 1 : 0

  security_group_id = aws_security_group.elb.id
  cidr_blocks       = var.source_cidrs
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 9200
  to_port           = 9200
}

resource "aws_security_group_rule" "elb_egress" {
  security_group_id = aws_security_group.elb.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

