output "mysql_fqdn" {
  description = "MySQL server fully qualified domain name."
  value       = azurerm_mysql_flexible_server.epicbook.fqdn
}