#!/bin/bash
# Run Terraform to apply infrastructure changes
terraform init
terraform apply -auto-approve

# Retrieve instance IP addresses and update Ansible inventory
INSTANCE_IP=$(terraform output -raw instance_ip)
echo "[gcp]" > ansible/inventory.ini
echo "$INSTANCE_IP" >> ansible/inventory.ini

# Run Ansible to deploy the application
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
