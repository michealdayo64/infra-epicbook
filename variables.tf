variable "project-name" {
  description = "The name of the project is epicbook dual deployment"
  type        = string
  default     = "epicbook"
}

variable "rg-epicbook" {
  description = "Description of the resource group for the Ansible Adhoc Lab"
  type        = string
  #default     = var.resource_group_name
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  #default     = var.location
}

variable "vnet-epicbook" {
  description = "Description of the virtual network for the Ansible Adhoc Lab"
  type        = string
  default     = "vnet-epicbook"
}

variable "vnet_cidr" {
  description = "CIDR block for the virtual network"
  type        = string
  #default     = var.vnet_cidr
}

variable "subnet-epicbook" {
  description = "Description of the first subnet for the Ansible Adhoc Lab"
  type        = list(string)
  default     = ["subnet-epicbook-1", "subnet-epicbook-2"]
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "database_subnet" {
  description = "Description of the database subnet for the Ansible Adhoc Lab"
  type        = string
  default     = "subnet-epicbook-3"
}

variable "database_subnet_cidr" {
  description = "CIDR block for the database subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "nsg-epicbook" {
  description = "Description of the network security group for the Ansible Adhoc Lab"
  type        = list(string)
  default     = ["nsg_epicbook_1", "nsg_epicbook_2", "nsg_epicbook_3"]
}

variable "vm_size" {
  description = "Azure VM size for frontend and backend."
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "admin_username" {
  description = "Linux administrator username."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key."
  type        = string
}

variable "allowed_admin_ip" {
  description = "CIDR allowed to SSH to the VMs."
  type        = string
}

variable "pipeline_agent_ip" {
  description = "CIDR of the Azure DevOps pipeline agent."
  type        = string
}

variable "backend_app_port" {
  description = "Port used by the backend Node.js application."
  type        = number
  default     = 3000
}

variable "db_admin_username" {
  description = "Azure MySQL administrator username."
  type        = string
  sensitive   = true
}

variable "db_admin_password" {
  description = "Azure MySQL administrator password."
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "EpicBook database name."
  type        = string
  default     = "epicbook"
}
