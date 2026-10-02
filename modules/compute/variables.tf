variable "rg-epicbook" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "frontend_subnet_id" {
  type = string
}

variable "backend_subnet_id" {
  type = string
}

variable "frontend_nsg_id" {
  type = string
}

variable "backend_nsg_id" {
  type = string
}