#!/bin/bash

# remember to set these vars to be able to use the cli
#VAULT_ADDR=http://IP:8200
#VAULT_TOKEN=""

projects="devops .. <and all other projects here>"

for project in $projects; do
   vault policy write -tls-skip-verify $project policies/$project.json
done
