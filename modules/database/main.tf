resource "azurerm_mysql_flexible_server" "epicbook" {
  name                = "epicbook-mysql-server"
  resource_group_name = var.rg-epicbook
  location            = var.location

  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password

  sku_name = "B_Standard_B1ms"
  #tier     = "Burstable"

  version = "8.0.21"

  backup_retention_days = 1

  zone = "1"

  storage {
    size_gb = 20
  }

  tags = {
    Name = "epicbook-mysql"
    Tier = "database"
  }
}

resource "azurerm_mysql_flexible_database" "epicbook" {
  name                = var.db_name
  resource_group_name = var.rg-epicbook
  server_name         = azurerm_mysql_flexible_server.epicbook.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}