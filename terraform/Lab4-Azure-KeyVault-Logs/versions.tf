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
    resource_group_name = "rg-Lab4Sergio-state-dev"
    storage_account_name = "st4vh0eybe2l"
    container_name = "tfstate"
    key = "devops-dev"
  }
}

provider "azurerm" {
  features {}
}