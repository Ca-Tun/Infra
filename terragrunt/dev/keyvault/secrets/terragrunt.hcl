include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../terraform/keyvault/secrets"
}

inputs = {
  resource_group_name         = "rg_keyvault_dev"
  location                    = "Southeast Asia" # Override parent if needed
  key_vault_name              = "kv-sea-dat-dev" # Choose a unique name
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  network_acls_default_action = "Allow" # More lenient for dev
  ip_rules                    = ["YOUR_DEV_IP_ADDRESS/32"] # Add your dev IP
  access_policy_object_id     = "YOUR_DEV_USER_OBJECT_ID" # Get from Azure AD (e.g., your own user ID)
  secret_permissions          = ["Get", "List", "Set", "Delete"]
  tags = {
    environment = "dev"
  }
  # New: Secret names for dev
  secret_name_user            = "MY-APP-USER" # Example: differentiating names per env
  secret_name_password        = "MY-APP-PASSWORD"
  secret_name_url             = "MY-APP-URL"
}
