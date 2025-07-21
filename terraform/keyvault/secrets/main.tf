terraform {
  backend "azurerm" {}
}

resource "azurerm_resource_group" "rg_default_dev" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "kv_sea_dat_dev" {
  name                            = var.key_vault_name
  location                        = azurerm_resource_group.rg_default_dev.location
  resource_group_name             = azurerm_resource_group.rg_default_dev.name
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
  key_vault_id            = azurerm_key_vault.kv_sea_dat_dev.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = var.access_policy_object_id # The object ID of the sp-GithubActions
#  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
#  certificate_permissions = var.certificate_permissions
}

# New: Secret for MY_APP_USER
resource "azurerm_key_vault_secret" "my_app_user" {
  name         = var.secret_name_user
  value        = "" # Initially empty
  key_vault_id = azurerm_key_vault.main.id
  content_type = "text/plain" # Or application/json, etc.
  tags         = var.tags # Inherit tags from Key Vault
}

# New: Secret for MY_APP_PASSWORD
resource "azurerm_key_vault_secret" "my_app_password" {
  name         = var.secret_name_password
  value        = "" # Initially empty
  key_vault_id = azurerm_key_vault.main.id
  content_type = "text/plain"
  tags         = var.tags
}

# New: Secret for MY_APP_URL
resource "azurerm_key_vault_secret" "my_app_url" {
  name         = var.secret_name_url
  value        = "" # Initially empty
  key_vault_id = azurerm_key_vault.main.id
  content_type = "text/plain"
  tags         = var.tags
}

data "azurerm_client_config" "current" {}

