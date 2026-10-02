resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-epicbook
  resource_group_name = var.rg-epicbook
  location            = var.location
  address_space       = [var.vnet_cidr]
}

resource "azurerm_subnet" "subnet_1" {
  name                 = var.subnet-epicbook[0]
  resource_group_name  = var.rg-epicbook
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr[0]]
}

resource "azurerm_subnet" "subnet_2" {
  name                 = var.subnet-epicbook[1]
  resource_group_name  = var.rg-epicbook
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr[1]]
}

resource "azurerm_subnet" "subnet_3" {
  name                 = var.database_subnet
  resource_group_name  = var.rg-epicbook
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.database_subnet_cidr]


  delegation {
    name = "mysql-flexible-server"

    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

resource "azurerm_network_security_group" "frontend_nsg_vm" {
  name                = var.nsg-epicbook[0]
  location            = var.location
  resource_group_name = var.rg-epicbook

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_admin_ip
    destination_address_prefix = "*"
  }

  /*security_rule {
    name                       = "Allow-SSH-Pipeline"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.pipeline_agent_ip
    destination_address_prefix = "*"
  }*/

  security_rule {
    name                       = "http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "public_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet_1.id
  network_security_group_id = azurerm_network_security_group.frontend_nsg_vm.id
}

resource "azurerm_network_security_group" "backend_nsg_vm" {
  name                = var.nsg-epicbook[1]
  location            = var.location
  resource_group_name = var.rg-epicbook

  security_rule {
    name                       = "ssh"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = azurerm_subnet.subnet_1.address_prefixes[0]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Backend-From-Frontend"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.backend_app_port
    source_address_prefix      = azurerm_subnet.subnet_1.address_prefixes[0]
    destination_address_prefix = "*"
  }

  /*security_rule {
    name                       = "Allow-SSH-Pipeline"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.pipeline_agent_ip
    destination_address_prefix = "*"
  }*/
}

resource "azurerm_subnet_network_security_group_association" "private_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet_2.id
  network_security_group_id = azurerm_network_security_group.backend_nsg_vm.id
}


resource "azurerm_network_security_group" "db_nsg" {
  name                = var.nsg-epicbook[2]
  location            = var.location
  resource_group_name = var.rg-epicbook

  security_rule {
    name                       = "mysql-db"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = azurerm_subnet.subnet_2.address_prefixes[0]
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet_3.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id
}
