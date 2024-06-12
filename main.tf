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
  name                = "cetech-ubuntu24"
  resource_group_name = "rg-shared-services"
}

output "image_id" {
  value = data.azurerm_image.search.id
}

resource "azurerm_resource_group" "rg-rt-prod" {
  name     = "rg-rt-prod"
  location = var.cetechllc_location
  tags = merge(local.tags, {
    git_commit           = "d2e65861995154e40a6315a5f997b04ecfd43843"
    git_file             = "main.tf"
    git_last_modified_at = "2024-04-29 13:21:31"
    git_last_modified_by = "cmoreira@misfirm.com"
    git_modifiers        = "cmoreira"
    git_org              = "cloudtherapy"
    git_repo             = "terraform-azure-rt"
    yor_name             = "rg-rt-prod"
    yor_trace            = "d03d43e3-51e3-4d3c-a454-6faf8b551c49"
  })
}

resource "azurerm_network_security_group" "nsg_rt" {
  name                = "nsg-rt-prod"
  location            = data.azurerm_virtual_network.vnet-shared.location
  resource_group_name = azurerm_resource_group.rg-rt-prod.name

  tags = merge(local.tags, {
    git_commit           = "d2e65861995154e40a6315a5f997b04ecfd43843"
    git_file             = "main.tf"
    git_last_modified_at = "2024-04-29 13:21:31"
    git_last_modified_by = "cmoreira@misfirm.com"
    git_modifiers        = "cmoreira"
    git_org              = "cloudtherapy"
    git_repo             = "terraform-azure-rt"
    yor_name             = "nsg_rt"
    yor_trace            = "988c82be-24a7-48c2-9620-c6e7dea08bd1"
  })
}

resource "azurerm_network_security_rule" "nsg_rules_rt" {
  for_each                    = local.nsgrules
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg-rt-prod.name
  network_security_group_name = azurerm_network_security_group.nsg_rt.name
}

resource "azurerm_public_ip" "pip_rt" {
  count               = var.enable_public_ip ? 1 : 0
  name                = format("pip-%s", "vm-rt-prod")
  resource_group_name = azurerm_resource_group.rg-rt-prod.name
  location            = data.azurerm_virtual_network.vnet-shared.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    git_commit           = "d2e65861995154e40a6315a5f997b04ecfd43843"
    git_file             = "main.tf"
    git_last_modified_at = "2024-04-29 13:21:31"
    git_last_modified_by = "cmoreira@misfirm.com"
    git_modifiers        = "cmoreira"
    git_org              = "cloudtherapy"
    git_repo             = "terraform-azure-rt"
    yor_name             = "pip_rt"
    yor_trace            = "10d838e3-c42d-4431-8dcd-c8c730a74798"
  }
}

resource "azurerm_network_interface" "vm-rt-prod-nic" {
  name                = "vm-rt-prod-nic"
  location            = azurerm_resource_group.rg-rt-prod.location
  resource_group_name = azurerm_resource_group.rg-rt-prod.name

  ip_configuration {
    name                          = "vm-rt-prod-ip"
    subnet_id                     = data.azurerm_subnet.snet-shared.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.pip_rt[0].id : ""
  }
  tags = {
    git_commit           = "cdfc79b1064a15a38029fd11f1debc06b64a5fba"
    git_file             = "main.tf"
    git_last_modified_at = "2024-04-29 13:30:19"
    git_last_modified_by = "cmoreira@misfirm.com"
    git_modifiers        = "cmoreira"
    git_org              = "cloudtherapy"
    git_repo             = "terraform-azure-rt"
    yor_name             = "vm-rt-prod-nic"
    yor_trace            = "81ddfb08-1238-468a-916d-46ab29296261"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_association_rt" {
  network_interface_id      = azurerm_network_interface.vm-rt-prod-nic.id
  network_security_group_id = azurerm_network_security_group.nsg_rt.id
}

resource "azurerm_virtual_machine" "vm-rt-prod" {
  name                  = "vm-rt-prod"
  location              = azurerm_resource_group.rg-rt-prod.location
  resource_group_name   = azurerm_resource_group.rg-rt-prod.name
  network_interface_ids = [azurerm_network_interface.vm-rt-prod-nic.id]
  vm_size               = "Standard_B2s"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = data.azurerm_image.search.id
  }

  storage_os_disk {
    name              = "vm-rt-prod-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 30
  }

  os_profile {
    computer_name  = "vm-rt-prod"
    admin_username = "ubuntu"
    admin_password = var.cetechllc_admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = merge(local.tags, {
    git_commit           = "39de2e7e45c8deb1225a0d4e4c23c22c45568b19"
    git_file             = "main.tf"
    git_last_modified_at = "2024-05-30 00:55:04"
    git_last_modified_by = "cmoreira@misfirm.com"
    git_modifiers        = "cmoreira"
    git_org              = "cloudtherapy"
    git_repo             = "terraform-azure-rt"
    yor_name             = "vm-rt-prod"
    yor_trace            = "4efacbc6-9d6b-49f9-ab31-a6f8fd1d2089"
  })
}