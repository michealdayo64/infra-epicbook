resource "azurerm_public_ip" "frontend" {
  name                = "epicbook-frontend-pip"
  resource_group_name = var.rg-epicbook
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Name = "epicbook-frontend-public-ip"
  }
}

resource "azurerm_network_interface" "frontend" {
  name                = "epicbook-frontend-nic"
  resource_group_name = var.rg-epicbook
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.frontend_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend.id
  }

  tags = {
    Name = "epicbook-frontend-nic"
  }
}

resource "azurerm_network_interface_security_group_association" "frontend" {
  network_interface_id      = azurerm_network_interface.frontend.id
  network_security_group_id = var.frontend_nsg_id
}

resource "azurerm_linux_virtual_machine" "frontend" {
  name                = "epicbook-frontend-vm"
  resource_group_name = var.rg-epicbook
  location            = var.location
  size                = var.vm_size

  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.frontend.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.root}/${var.ssh_public_key_path}")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    Name = "epicbook-frontend"
    Tier = "frontend"
  }
}

resource "azurerm_network_interface" "backend" {
  name                = "epicbook-backend-nic"
  resource_group_name = var.rg-epicbook
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.backend_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Name = "epicbook-backend-nic"
  }
}

resource "azurerm_network_interface_security_group_association" "backend" {
  network_interface_id      = azurerm_network_interface.backend.id
  network_security_group_id = var.backend_nsg_id
}

resource "azurerm_linux_virtual_machine" "backend" {
  name                = "epicbook-backend-vm"
  resource_group_name = var.rg-epicbook
  location            = var.location
  size                = var.vm_size

  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.backend.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    Name = "epicbook-backend"
    Tier = "backend"
  }
}