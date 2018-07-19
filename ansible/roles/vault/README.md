Role Name
=========

This module installs ,
* go 1.10.2
* consul
* vault latest
* create system user vault
* adjust policies to get vault running confined
* create a systemctl service for vault and for consul
* Backend configured is Consul for now
* It doesn't init / unseal the vault
* VAULT_ADDR=localhost:8200

Requirements
------------

This should be run on the EC2 instances created by Terraform. https://data-cbre.visualstudio.com/EnterpriseDataPlatform/_git/emea_devops_terraform


Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

Requires:
  go
  wget
  unzip
  policycoreutils-python

Example Playbook
----------------

To create a consul/vault cluster, set mode: cluster.   For a single box to be configured, mode:srv.

    - hosts: servers
      roles:
         - { role: vault, mode: srv|cluster, consul_members: [ <list of ips> ] }


Author Information
------------------

Laura Herrera
