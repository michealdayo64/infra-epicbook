#subscription_id = "5b3f6a98-ff36-4baf-9904-6bc34a0f8981"
# Azure region
#location = "West Europe"
location = "South Africa North"

# Azure Resource Group
rg-epicbook = "rg-epicbook"

# VNet
vnet_cidr = "10.0.0.0/16"

#
#jdjdj
# Frontend
#frontend_subnet_cidr = "10.20.1.0/24"

# Backend
#backend_subnet_cidr = "10.20.2.0/24"

# Database
#database_subnet_cidr = "10.20.3.0/24"

# VM
#vm_size       = "Standard_B1s"
#admin_username = "azureuser"

# SSH public key
# Use your own local public key path.
ssh_public_key_path = "id_ed25519.pub"

# Replace with your actual IP /32.
allowed_admin_ip = "102.89.46.228/32"

# Replace with your Azure DevOps agent's reachable IP /32.
pipeline_agent_ip = "REPLACE_WITH_PIPELINE_AGENT_IP/32"

# Node.js backend
backend_app_port = 3000

# Database
db_name = "epicbook"

# DO NOT put these here:
#
# db_admin_username
# db_admin_password
#
# Supply them through:
#
# TF_VAR_db_admin_username
# TF_VAR_db_admin_password
#
# or Azure DevOps secret variables.