terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = azurerm_resource_group.oidc.name  # Nome do Resource Group onde o Storage Account está
    storage_account_name = azurerm_storage_account.oidc.name # Nome do Storage Account
    container_name       = azurerm_storage_container.Container.name        # Nome do Container criado
    key                  = "terraform.tfstate"       # Nome do arquivo de estado
  }
}

provider "azurerm" {
  features {
    
  }
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