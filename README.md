# Introduction 

Creates a Consul + Vault cluster, built with Terraform and configured with Ansible

# Getting Started
Terraform
1. Uses a set of modules to build a cluster
2. Creates an Auto Scaling Group
3. Creates all Security Groups needed
4. Creates an IAM policy that associates to each node

Ansible:
1. Installs and configures Consul
2. Installs and configures Vault
3. Configures vault with TLS
4. Includes a couple of scripts to create a structure for secrets


# Playbook
Add the list of IPs as consul_members for consul startup.

```
---
- hosts: all
  become: true
  roles:
    - { role: vault, mode: cluster, consul_members: [] }
```

# Usage
```ansible-playbook -i hosts  playbook.yml```


