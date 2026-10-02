output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "frontend_subnet_id" {
  value = azurerm_subnet.subnet_1.id
}

output "backend_subnet_id" {
  value = azurerm_subnet.subnet_2.id
}

output "database_subnet_id" {
  value = azurerm_subnet.subnet_3.id
}

output "frontend_nsg_id" {
  value = azurerm_network_security_group.frontend_nsg_vm.id
}

output "backend_nsg_id" {
  value = azurerm_network_security_group.backend_nsg_vm.id
}

output "database_nsg_id" {
  value = azurerm_network_security_group.db_nsg.id
}