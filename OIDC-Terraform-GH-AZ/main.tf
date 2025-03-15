
provider "azurerm" {
  features {
  }
  use_oidc = true

}

resource "azurerm_resource_group" "oidc" {
  name     = "rg-oidc-teste"
  location = var.azure_region
}

