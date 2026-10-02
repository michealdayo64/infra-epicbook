variable "rg-epicbook" {
  type = string
}

variable "location" {
  type = string
}

/*variable "subnet-epicbook" {
  type = list(string)
}

variable "database_subnet" {
  type = string
}

variable "database_nsg_id" {
  type = list(string)
}*/

variable "db_admin_username" {
  type      = string
  sensitive = true
}

variable "db_admin_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type = string
}