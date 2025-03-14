provider "azurerm" {
  features {}
}

# Cria uma storage account para armazenar o estado
resource "random_integer" "oidc" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "oidc" {
  name     = "oidc-${random_integer.oidc.result}"
  location = var.azure_region
}

resource "azurerm_storage_account" "oidc" {
  resource_group_name = azurerm_resource_group.oidc.name
  location            = azurerm_resource_group.oidc.location
  name                = "oidc${random_integer.oidc.result}"

  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a container
resource "azurerm_storage_container" "Container" {
  name                 = "oidc-ct-blog"
  storage_account_name = azurerm_storage_account.oidc.name
}