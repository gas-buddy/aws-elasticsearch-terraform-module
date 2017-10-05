resource "aws_instance" "data_a" {
  count = "${contains(keys(var.subnet_ids), "a") ? (var.data_nodes_per_subnet) : 0}"

  instance_type = "${var.data_instance_type}"
  ami = "${var.hvm_ami}"
  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"
  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_data.id}"))}"
  ]
  subnet_id = "${var.subnet_ids["a"]}"
  monitoring = "${var.data_monitoring}"

  tags = "${merge(var.tags, map("Name", format("elasticsearch-data-%s-1a-%d", var.cluster_name, count.index+1)))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.data_a.public_ip},' ${var.data_ansible_playbook}"
  }
}

resource "aws_instance" "data_b" {
  count = "${contains(keys(var.subnet_ids), "b") ? (var.data_nodes_per_subnet) : 0}"

  instance_type = "${var.data_instance_type}"
  ami = "${var.hvm_ami}"

  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"

  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_data.id}"))}"
  ]

  subnet_id = "${lookup(var.subnet_ids, "b", "")}"
  monitoring = "${var.data_monitoring}"

  tags = "${merge(var.tags, map("Name", format("elasticsearch-data-%s-1b-%d", var.cluster_name, count.index+1)))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.data_b.public_ip},' ${var.data_ansible_playbook}"
  }
}

resource "aws_instance" "data_c" {
  count = "${contains(keys(var.subnet_ids), "c") ? (var.data_nodes_per_subnet) : 0}"

  instance_type = "${var.data_instance_type}"
  ami = "${var.hvm_ami}"

  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"

  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_data.id}"))}"
  ]

  subnet_id = "${lookup(var.subnet_ids, "c", "")}"
  monitoring = "${var.data_monitoring}"

  tags = "${merge(var.tags, map("Name", format("elasticsearch-data-%s-1c-%d", var.cluster_name, count.index+1)))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.data_c.public_ip},' ${var.data_ansible_playbook}"
  }
}

resource "aws_instance" "data_d" {
  count = "${contains(keys(var.subnet_ids), "d") ? (var.data_nodes_per_subnet) : 0}"

  instance_type = "${var.data_instance_type}"
  ami = "${var.hvm_ami}"

  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"

  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_data.id}"))}"
  ]

  subnet_id = "${lookup(var.subnet_ids, "d", "")}"
  monitoring = "${var.data_monitoring}"

  tags = "${merge(var.tags, map("Name", format("elasticsearch-data-%s-1d-%d", var.cluster_name, count.index+1)))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.data_d.public_ip},' ${var.data_ansible_playbook}"
  }
}

resource "aws_instance" "data_e" {
  count = "${contains(keys(var.subnet_ids), "e") ? (var.data_nodes_per_subnet) : 0}"


  instance_type = "${var.data_instance_type}"
  ami = "${var.hvm_ami}"

  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"

  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_data.id}"))}"
  ]

  subnet_id = "${lookup(var.subnet_ids, "e", "")}"
  monitoring = "${var.data_monitoring}"

  tags = "${merge(var.tags, map("Name", format("elasticsearch-data-%s-1e-%d", var.cluster_name, count.index+1)))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.data_e.public_ip},' ${var.data_ansible_playbook}"
  }
}

