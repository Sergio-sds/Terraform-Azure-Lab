terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.44.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.6.3"
    }
  }
  backend "azurerm" {

  }
}

/*

  backend "azurerm" {
    resource_group_name = "rg-Lab3Sergio-state-dev"
    storage_account_name = "st4vh0eybe2l"
    container_name = "tfstate"
    key = "observability-dev"
  }
}

*/

provider "azurerm" {
  features {}
}
