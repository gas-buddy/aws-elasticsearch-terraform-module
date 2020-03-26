resource "aws_iam_instance_profile" "this" {
  name = "${var.iam_instance_profile_name}"
  role = "${aws_iam_role.this.name}"
}

resource "aws_iam_role" "this" {
  name = "${var.iam_instance_profile_name}"
  path = "/"

  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  role = "${aws_iam_role.this.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
