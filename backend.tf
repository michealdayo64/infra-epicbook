terraform {
  backend "azurerm" {
    resource_group_name  = "rg-epicbook"
    storage_account_name = "epicbooktfstate20261002"
    container_name       = "tfstate"
    key                  = "epicbook.terraform.tfstate"
    use_azuread_auth     = true
  }
}