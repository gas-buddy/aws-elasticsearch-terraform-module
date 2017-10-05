resource "aws_instance" "master_a" {
  count = "${contains(keys(var.subnet_ids), "a") ? 1 : 0}"

  instance_type = "${var.master_instance_type}"
  ami = "${var.pv_ami}"
  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"
  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_master.id}"))}"
  ]
  subnet_id = "${lookup(var.subnet_ids, "a", "")}"
  monitoring = "${var.master_monitoring}"

  tags = "${merge(var.tags, map("Name", "elasticsearch-master-${var.cluster_name}-1a"))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.master_a.public_ip},' ${var.master_ansible_playbook}"
  }
}

resource "aws_instance" "master_b" {
  count = "${contains(keys(var.subnet_ids), "b") ? 1 : 0}"

  instance_type = "${var.master_instance_type}"
  ami = "${var.pv_ami}"

  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"

  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_master.id}"))}"
  ]

  subnet_id = "${lookup(var.subnet_ids, "b", "")}"
  monitoring = "${var.master_monitoring}"

  tags = "${merge(var.tags, map("Name", "elasticsearch-master-${var.cluster_name}-1b"))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.master_b.public_ip},' ${var.master_ansible_playbook}"
  }
}

resource "aws_instance" "master_c" {
  count = "${contains(keys(var.subnet_ids), "c") ? 1 : 0}"

  instance_type = "${var.master_instance_type}"
  ami = "${var.pv_ami}"

  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"

  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_master.id}"))}"
  ]

  subnet_id = "${lookup(var.subnet_ids, "c", "")}"
  monitoring = "${var.master_monitoring}"

  tags = "${merge(var.tags, map("Name", "elasticsearch-master-${var.cluster_name}-1c"))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.master_c.public_ip},' ${var.master_ansible_playbook}"
  }
}

resource "aws_instance" "master_d" {
  count = "${contains(keys(var.subnet_ids), "d") ? 1 : 0}"

  instance_type = "${var.master_instance_type}"
  ami = "${var.pv_ami}"

  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"

  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_master.id}"))}"
  ]

  subnet_id = "${lookup(var.subnet_ids, "d", "")}"
  monitoring = "${var.master_monitoring}"

  tags = "${merge(var.tags, map("Name", "elasticsearch-master-${var.cluster_name}-1d"))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.master_d.public_ip},' ${var.master_ansible_playbook}"
  }
}

resource "aws_instance" "master_e" {
  count = "${contains(keys(var.subnet_ids), "e") ? 1 : 0}"


  instance_type = "${var.master_instance_type}"
  ami = "${var.pv_ami}"

  key_name = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"

  vpc_security_group_ids = [
    "${concat(var.additional_security_group_ids, list("${aws_security_group.elasticsearch_master.id}"))}"
  ]

  subnet_id = "${lookup(var.subnet_ids, "e", "")}"
  monitoring = "${var.master_monitoring}"

  tags = "${merge(var.tags, map("Name", "elasticsearch-master-${var.cluster_name}-1e"))}"

  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} --private-key ${var.ssh_key_file} '${aws_instance.master_e.public_ip},' ${var.master_ansible_playbook}"
  }
}
