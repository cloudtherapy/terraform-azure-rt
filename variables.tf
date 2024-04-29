variable "cetechllc_location" {
  description = "The Azure Region in which all resources should be created."
  default     = "East US"
}

variable "cetechllc_client_id" {
  description = "The Client ID of the Azure AD Application."
  type        = string
  sensitive   = true
}

variable "cetechllc_client_secret" {
  description = "The Client Secret of the Azure AD Application."
  type        = string
  sensitive   = true
}

variable "cetechllc_tenant_id" {
  description = "The Tenant ID of the Azure AD Application."
  type        = string
  sensitive   = true
}

variable "cetechllc_subscription_id" {
  description = "The Subscription ID of the Azure Subscription."
  type        = string
  sensitive   = true
}

variable "cetechllc_admin_password" {
  description = "The password for the local administrator account."
  type        = string
  sensitive   = true
}

variable "enable_public_ip" {
  type        = bool
  description = "Configuration setting to enable or disable providing a public IP"
  default     = true
}