resource "azurerm_resource_group" "cetech-tfc-rg" {
  name     = "cetech-tfc-rg"
  location = "East US"
}

resource "azurerm_storage_account" "cetech-tfc" {
  name                     = "cetech-tfc"
  resource_group_name      = azurerm_resource_group.cetech-tfc-rg.name
  location                 = azurerm_resource_group.cetech-tfc-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "terraform-cloud"
  }
}
