resource "null_resource" "load_ansible_roles" {
  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=${var.ansible_playbook}/ansible.cfg ansible-galaxy install -r ${var.ansible_playbook}/requirements.yml"
  }
}
