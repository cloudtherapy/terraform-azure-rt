terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.47.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.97.1"
    }
  }
}

provider "azuread" {
}

provider "azurerm" {
  features {}
  client_id       = var.cetechllc_client_id
  client_secret   = var.cetechllc_client_secret
  tenant_id       = var.cetechllc_tenant_id
  subscription_id = var.cetechllc_subscription_id
}

data "azurerm_shared_image" "cetech-ubuntu-image" {
  name                = "cetech-ubuntu22"
  gallery_name        = "cetech-images"
  resource_group_name = "rg-shared-resources"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-rt-prod"
  location = var.cetechllc_location
}
