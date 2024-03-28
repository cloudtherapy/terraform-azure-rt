# terraform-azure-rt
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.47.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.97.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.97.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/resources/resource_group) | resource |
| [azurerm_shared_image.cetech-ubuntu-image](https://registry.terraform.io/providers/hashicorp/azurerm/3.97.1/docs/data-sources/shared_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cetechllc_client_id"></a> [cetechllc\_client\_id](#input\_cetechllc\_client\_id) | The Client ID of the Azure AD Application. | `string` | n/a | yes |
| <a name="input_cetechllc_client_secret"></a> [cetechllc\_client\_secret](#input\_cetechllc\_client\_secret) | The Client Secret of the Azure AD Application. | `string` | n/a | yes |
| <a name="input_cetechllc_location"></a> [cetechllc\_location](#input\_cetechllc\_location) | The Azure Region in which all resources should be created. | `string` | `"East US"` | no |
| <a name="input_cetechllc_subscription_id"></a> [cetechllc\_subscription\_id](#input\_cetechllc\_subscription\_id) | The Subscription ID of the Azure Subscription. | `string` | n/a | yes |
| <a name="input_cetechllc_tenant_id"></a> [cetechllc\_tenant\_id](#input\_cetechllc\_tenant\_id) | The Tenant ID of the Azure AD Application. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->