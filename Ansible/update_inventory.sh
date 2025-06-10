#!/bin/bash

TERRAFORM_OUTPUT_DIR="D:\TWS\Terraform-Ansible\Terraform"  
ANSIBLE_INVENTORY_DIR="D:\TWS\Terraform-Ansible\Ansible\Inventory"

cd "$TERRAFORM_OUTPUT_DIR" || { echo "TERRAFORM DIRECTORY NOT FOUND"; exit 1; }

DEV_IPS=$(terraform output -json dev_infra_instance_public_ips | jq -r '.[]')
STG_IPS=$(terraform output -json stg_infra_instance_public_ips | jq -r '.[]')
PRD_IPS=$(terraform output -json prd_infra_instance_public_ips | jq -r '.[]') 

update_inventory_file() {
    local ips="$1"
    local inventory_file="$2"
    local env="$3"

    > "$inventory_file"

    echo "[servers]" >> "$inventory_file"

    local count=1
    for ip in $ips; do
        echo "SERVER${count} ANSIBLE HOST=$ip" >> "$inventory_file"
        count=$((count + 1))
    done

    echo "" >> "$inventory_file"
    echo "[servers:vars]" >> "$inventory_file"
    echo "ansible_user=ubuntu" >> "$inventory_file"
    echo "ansible_ssh_private_key_file=/home/ubuntu/keys/ec2-security-key.pem" >> "$inventory_file"
    echo "ansible_python_interpreter=/usr/bin/python3" >> "$inventory_file"

    echo "UPDATED $env INVENTORY - $inventory_file"
}

update_inventory_file "$DEV_IPS" "$ANSIBLE_INVENTORY_DIR/dev" "DEV"
update_inventory_file "$STG_IPS" "$ANSIBLE_INVENTORY_DIR/stg" "STG"
update_inventory_file "$PRD_IPS" "$ANSIBLE_INVENTORY_DIR/prd" "PRD" 

