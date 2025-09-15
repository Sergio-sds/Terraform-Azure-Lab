# Azure Provider source and version being used
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
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # change tihs before updloading to GitHub repo
  # subscription_id = "subID"

  # we can also add the ID to the variable $env to avoid typing it in the file
  # $env:ARM_SUBSCRIPTION_ID = "subID"
  # for bash we run export ARM_SUBSCRIPTION_ID="subID"
}

# Commands used
# terraform init -upgrade ,this is used to upgrade a provider to a newer version

# az account show ,this will show us information about our subscription/s
# if you got more than one subscription you will have to use, az account list instead