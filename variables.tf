variable "env" {
  description = "The environment name"
  type = "string"
}

variable "data_nodes_per_subnet" {
  default = 1
}

variable "source_security_group_ids" {
  description = "A list of security groups (by ID) that are allowed to access port 9200 on the ES masters"
  type = "list"
}

variable "data_storage_gb" {
  description = "GB of index data storage for each data node."
  default = 250
}

variable "logs_storage_gb" {
  description = "GB of index data storage for each data node."
  default = 50
}

variable "storage_type" {
  default = "gp2"
}

variable "source_cidrs" {
  description = "(Optional) CIDR ranges to allow accesss from"
  type = "list"
  default = []
}

variable "cluster_name" {
  default = "default"
}

variable "additional_security_group_ids" {
  description = "Additional groups to assign to all nodes in the search cluster"
  default = []
}

variable "key_name" {
  type = "string"
}

variable "subnet_ids" {
  type = "map"
}

variable "vpc_id" {
  type = "string"
}

# Security Group IDs

variable "master_instance_type" {
  default = "m1.small"
}

variable "master_instance_spot_price" {
  default = "0.44"
}

variable "data_instance_type" {
  default = "i3.xlarge"
}

variable "data_instance_spot_price" {
  default = "0.32"
}

variable "hvm_ami" {
  default = "ami-d651b8ac" # ami-d651b8ac  16.04 LTS  hvm:ebs-ssd 20170919
}

variable "pv_ami" {
  default = "ami-3d55bc47" # ami-3d55bc47  16.04 LTS  ebs-ssd 20170919
}

variable "data_monitoring" {
  description = "Detailed monitoring for data nodes (costs extra)"
  default = false
}

variable "master_monitoring" {
  description = "Detailed monitoring for master nodes (costs extra)"
  default = false
}

variable "tags" {
  type = "map"
  description = "Additional tags to include with the instance"
  default = {}
}

variable "iam_instance_profile" {}

variable "ssh_key_file" {
  type = "string"
}

variable "ssh_user" {
  type = "string"
  default = "ubuntu"
}

variable "ansible_playbook" {
  type = "string"
}

variable "device_names" {
  default = {
    data = "h"
    logs = "i"
  }
}

variable "region" {
  default = "us-east-1"
}

variable "ca_passphrase_file" {
  description = "The file containing the certificate authority key passphrase"
}

# Chef Provisioner...
# variable "chef_user_name" {}
# variable "chef_client_key_file" {}
# variable "master_run_list" {
#   type = "list"
#   default = ["recipe[et_base]", "recipe[et_contacts_search]","role[es_master]"]
# }
