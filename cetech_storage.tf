resource "azurerm_resource_group" "cetech-tfc-rg" {
  name     = "cetech-tfc-rg"
  location = "East US"
  tags = {
    yor_name  = "cetech-tfc-rg"
    yor_trace = "29b92cae-853f-4b9c-8e2b-71a0ed1be99e"
  }
}

resource "azurerm_storage_account" "cetech-tfc" {
  name                     = "cetech-tfc"
  resource_group_name      = azurerm_resource_group.cetech-tfc-rg.name
  location                 = azurerm_resource_group.cetech-tfc-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "terraform-cloud"
    yor_name    = "cetech-tfc"
    yor_trace   = "a988eb17-c1b9-4977-9929-90abd84d5e3d"
  }
}
