module "master_1b" {
  source = "../../"

  key_name = "default"

  subnet_ids = {
    b = "subnet-a1b2c3d4"
    c = "subnet-e5f6g7h8"
    d = "subnet-i9j0k1l2"
  }

  data_nodes_per_subnet = 2
  source_security_group_ids = [
    "sg-01234567",
    "sg-89abcdef"
  ]

  source_cidrs = ["1.2.3.4/32"]

  vpc_id = "vpc-a1b2c3d4"
  ssh_key_file = "~/.ssh/default.pem"
}
