output "elb_dns_name" {
  value = "${aws_elb.masters.dns_name}"
}
