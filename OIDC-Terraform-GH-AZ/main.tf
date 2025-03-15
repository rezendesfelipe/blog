
provider "azurerm" {
  features {
  }
  use_oidc = true
}

resource "azurerm_resource_group" "oidc" {
  name     = "oidc-${random_integer.oidc.result}"
  location = var.azure_region
}

