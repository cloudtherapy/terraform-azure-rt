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

data "azurerm_virtual_network" "vnet-shared" {
  name                = "vnet-shared-10-253-0"
  resource_group_name = "rg-shared-services"
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.vnet-shared.id
}

data "azurerm_subnet" "snet-shared" {
  name                 = "snet-shared-10-253-0-0"
  virtual_network_name = data.azurerm_virtual_network.vnet-shared.name
  resource_group_name  = data.azurerm_virtual_network.vnet-shared.resource_group_name
}

output "subnet_id" {
  value = data.azurerm_subnet.snet-shared.id
}

data "azurerm_image" "search" {
  name                = "cetech-ubuntu22"
  resource_group_name = "rg-shared-services"
}

output "image_id" {
  value = data.azurerm_image.search.id
}

resource "azurerm_resource_group" "rg-rt-prod" {
  name     = "rg-rt-prod"
  location = var.cetechllc_location
}

resource "azurerm_network_interface" "vm-rt-prod-nic" {
  name                = "vm-rt-prod-nic"
  location            = azurerm_resource_group.rg-rt-prod.location
  resource_group_name = azurerm_resource_group.rg-rt-prod.name

  ip_configuration {
    name                          = "vm-rt-prod-ip"
    subnet_id                     = data.azurerm_subnet.snet-shared.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm-rt-prod" {
  name                  = "vm-rt-prod"
  location              = azurerm_resource_group.rg-rt-prod.location
  resource_group_name   = azurerm_resource_group.rg-rt-prod.name
  network_interface_ids = [azurerm_network_interface.vm-rt-prod-nic.id]
  vm_size               = "Standard_B2s"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = data.azurerm_image.search.id
  }

  storage_os_disk {
    name              = "vm-rt-prod-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "vm-rt-prod"
    admin_username = "ubuntu"
    admin_password = var.cetechllc_admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}