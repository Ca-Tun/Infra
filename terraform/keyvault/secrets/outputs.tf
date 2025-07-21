output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.kv-sea-dat-dev.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault."
  value       = azurerm_key_vault.kv-sea-dat-dev.vault_uri
}
