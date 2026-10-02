output "frontend_public_ip" {
  description = "Public IP of the frontend VM."
  value       = azurerm_public_ip.frontend.ip_address
}

output "frontend_private_ip" {
  description = "Private IP of the frontend VM."
  value       = azurerm_network_interface.frontend.private_ip_address
}

output "backend_private_ip" {
  description = "Private IP of the backend VM."
  value       = azurerm_network_interface.backend.private_ip_address
}