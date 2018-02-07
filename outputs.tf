output "elb_dns_name" {
  value = "${aws_elb.masters.dns_name}"
}

output "master_a_ip" {
  value = "${aws_instance.master_a.*.private_ip}"
}

output "master_b_ip" {
  value = "${aws_instance.master_b.*.private_ip}"
}

output "master_c_ip" {
  value = "${aws_instance.master_c.*.private_ip}"
}
