terraform {
  backend "azurerm" {}
}

resource "azurerm_resource_group" "rg-default-dev" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "kv-sea-dat-dev" {
  name                            = var.key_vault_name
  location                        = azurerm_resource_group.rg-default-dev.location
  resource_group_name             = azurerm_resource_group.rg-default-dev.name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.sku_name
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

#  network_acls {
#    default_action = var.network_acls_default_action
#    bypass         = "AzureServices"
#    ip_rules       = var.ip_rules
#    # Add virtual_network_subnet_ids if you are using private endpoints or service endpoints
#  }

  tags = var.tags
}

# Granting an access policy to a service principal sp-GithubActions
# Passing in object IDs and permissions from Terragrunt.
resource "azurerm_key_vault_access_policy" "example" {
  key_vault_id            = azurerm_key_vault.kv-sea-dat-dev.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = var.access_policy_object_id # The object ID of the sp-GithubActions
#  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
#  certificate_permissions = var.certificate_permissions
}

data "azurerm_client_config" "current" {}

