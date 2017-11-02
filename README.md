# Terraform Elasticsearch Module for AWS

Use this to set up an Elasticsearch cluster using the AWS provider

## Usage

Note that some of the Terraform config files in here are shipped as ERuby templates rather than .tf files. The files must be rendered before the module can be used. To do so, run:

```
./process_templates.rb
```

The Ansible playbook that this module calls depends on having a vault password to decrypt encrypted variables. That password file is expected to be stored in:

```
~/.ansible/vault-password
```

the actual password is available in 1Password in the GasBuddy DevOps vault under the name "Ansible Vault Password."
