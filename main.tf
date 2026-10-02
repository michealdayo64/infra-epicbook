resource "azurerm_resource_group" "rg" {
  name     = var.rg-epicbook
  location = var.location

  tags = {
    Project = "EpicBook"
    #Environment = "lab"
  }
}


module "network" {
  source = "./modules/network"

  rg-epicbook      = azurerm_resource_group.rg.name
  location         = azurerm_resource_group.rg.location
  backend_app_port = var.backend_app_port
  vnet-epicbook    = var.vnet-epicbook
  vnet_cidr        = var.vnet_cidr
  subnet-epicbook  = var.subnet-epicbook
  subnet_cidr      = var.subnet_cidr
  database_subnet     = var.database_subnet
  database_subnet_cidr = var.database_subnet_cidr
  nsg-epicbook     = var.nsg-epicbook
  allowed_admin_ip = var.allowed_admin_ip
}

module "compute" {
  source = "./modules/compute"

  rg-epicbook = azurerm_resource_group.rg.name
  location    = azurerm_resource_group.rg.location

  vm_size        = var.vm_size
  admin_username = var.admin_username

  ssh_public_key_path = var.ssh_public_key_path

  frontend_subnet_id = module.network.frontend_subnet_id
  backend_subnet_id  = module.network.backend_subnet_id

  frontend_nsg_id = module.network.frontend_nsg_id
  backend_nsg_id  = module.network.backend_nsg_id
}

module "database" {
  source = "./modules/database"

  rg-epicbook = azurerm_resource_group.rg.name
  location    = azurerm_resource_group.rg.location

  #database_subnet = module.network.database_subnet_id

  #database_nsg_id = module.network.database_nsg_id

  db_admin_username = var.db_admin_username
  db_admin_password = var.db_admin_password
  db_name           = var.db_name
}