include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../terraform/keyvault/secrets"
}

inputs = {
  resource_group_name         = "rg_keyvault_prod"
  location                    = "Southeast Asia" # Override parent if needed
  key_vault_name              = "kv-sea-dat-prod" # Choose a unique name
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  network_acls_default_action = "Allow" # More lenient for prod
  ip_rules                    = ["YOUR_PROD_IP_ADDRESS/32"] # Add your prod IP
  access_policy_object_id     = "226120fa-47d7-4311-9942-f459938531b1" # Get from Azure AD (e.g., your own user ID)
  secret_permissions          = ["Get", "List", "Set", "Delete", "Purge"]
  tags = {
    environment = "prod"
  }
  # New: Secret names for prod
  secret_name_user            = "MY-APP-USER"
  secret_name_password        = "MY-APP-PASSWORD"
  secret_name_url             = "MY-APP-URL"
}
