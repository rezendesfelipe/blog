terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
   
    key = "terraform.tfstate"       # Nome do arquivo de estado
    use_oidc = true
    use_azuread_auth = true
  }
}
