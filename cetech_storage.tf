resource "azurerm_resource_group" "cetech-tfc-rg" {
  name     = "cetech-tfc-rg"
  location = "East US"
  tags = {
    yor_name             = "cetech-tfc-rg"
    yor_trace            = "29b92cae-853f-4b9c-8e2b-71a0ed1be99e"
    git_commit           = "fc138ae41065132dc4f7bc118c50398bb36a3814"
    git_file             = "cetech_storage.tf"
    git_last_modified_at = "2024-06-13 15:04:43"
    git_last_modified_by = "63737479+k-laughman@users.noreply.github.com"
    git_modifiers        = "63737479+k-laughman"
    git_org              = "cloudtherapy"
    git_repo             = "terraform-azure-rt"
  }
}

resource "azurerm_storage_account" "cetechtfc" {
  name                     = "cetechtfc"
  resource_group_name      = azurerm_resource_group.cetech-tfc-rg.name
  location                 = azurerm_resource_group.cetech-tfc-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment          = "terraform-cloud"
    yor_name             = "cetech-tfc"
    yor_trace            = "a988eb17-c1b9-4977-9929-90abd84d5e3d"
    git_commit           = "fc138ae41065132dc4f7bc118c50398bb36a3814"
    git_file             = "cetech_storage.tf"
    git_last_modified_at = "2024-06-13 15:04:43"
    git_last_modified_by = "63737479+k-laughman@users.noreply.github.com"
    git_modifiers        = "63737479+k-laughman"
    git_org              = "cloudtherapy"
    git_repo             = "terraform-azure-rt"
  }
}
