output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.kv_sea_dat_dev.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault."
  value       = azurerm_key_vault.kv_sea_dat_dev.vault_uri
}
