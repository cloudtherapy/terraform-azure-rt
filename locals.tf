locals {

  tags = {
    "cetech:contact"  = "cmoreira"
    "env:platform"    = "azure-mis"
    "app:name"        = "Request Tracker"
    "app:tier"        = "Production"
    "env:provisioner" = "Terraform"
  }

  nsgrules = {
    AllowSSHInBound = {
      name                       = "AllowSSHInBound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    }
    AllowHTTPInBound = {
      name                       = "AllowHTTPInBound"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
    }
    AllowHTTPSInBound = {
      name                       = "AllowHTTPSInBound"
      priority                   = 300
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
    }
    AllowSMTPInBound = {
      name                       = "AllowSMTPInBound"
      priority                   = 400
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "25"
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
    }
  }
}