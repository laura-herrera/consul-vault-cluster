#!/bin/bash

# remember to set these vars to be able to use the cli
#VAULT_ADDR=http://IP:8200
#VAULT_TOKEN=""

environments="devops .. <and all other projects here>"

for env in $environments; do
   vault write -tls-skip-verify secret/$env/_created value="`date`"
done
