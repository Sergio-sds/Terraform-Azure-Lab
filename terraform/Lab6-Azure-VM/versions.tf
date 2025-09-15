terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.44.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.2.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.6.3"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-Lab6-LinuxVM-prod"
    storage_account_name = "st4vh0eybe2l"
    container_name = "tfstate"
    key = "devops-prod"
  }
}

provider "azurerm" {
  features {}
}