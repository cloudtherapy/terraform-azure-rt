terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "2.47.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.97.1"
    }
  }
}

provider "azuread" {
  version = "=2.47.0"
}

provider "azurerm" {
  version = "=3.97.1"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-vm-request-tracker"
  location = var.location
}
