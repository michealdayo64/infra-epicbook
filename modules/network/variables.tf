variable "rg-epicbook" {
  description = "Description of the resource group for the Ansible Adhoc Lab"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "vnet-epicbook" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for the virtual network"
  type        = string
}

variable "subnet-epicbook" {
  description = "Description of the first subnet for the Ansible Adhoc Lab"
  type        = list(string)
}

variable "database_subnet" {
  description = "Description of the database subnet for the Ansible Adhoc Lab"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = list(string)
}

variable "database_subnet_cidr" {
  description = "CIDR block for the database subnet"
  type        = string
}

variable "nsg-epicbook" {
  description = "Description of the network security group for the Ansible Adhoc Lab"
  type        = list(string)
}

variable "backend_app_port" {
  description = "Port used by the backend Node.js application."
  type        = number
}

variable "allowed_admin_ip" {
  description = "The IP address allowed to access the VMs via SSH."
  type        = string
}