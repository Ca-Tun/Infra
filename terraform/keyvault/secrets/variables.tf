variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Key Vault will be created."
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the Key Vault. (standard or premium)"
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained after soft-delete."
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Boolean flag to specify whether purge protection is enabled for this Key Vault."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is enabled for this Key Vault."
  type        = bool
  default     = false
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve secrets stored as passwords from the Key Vault."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the Key Vault."
  type        = bool
  default     = false
}

variable "network_acls_default_action" {
  description = "The default network ACL action. (Allow or Deny)"
  type        = string
  default     = "Deny"
}

variable "ip_rules" {
  description = "A list of IP addresses or CIDR ranges that are allowed to access the Key Vault."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the Key Vault."
  type        = map(string)
  default     = {}
}

variable "access_policy_object_id" {
  description = "The object ID of the user, service principal, or managed identity to grant access to."
  type        = string
}

variable "key_permissions" {
  description = "List of key permissions to grant."
  type        = list(string)
  default     = []
}

variable "secret_permissions" {
  description = "List of secret permissions to grant."
  type        = list(string)
  default     = ["Get", "List", "Set"]
}

variable "certificate_permissions" {
  description = "List of certificate permissions to grant."
  type        = list(string)
  default     = []
}

# New: Variables for secret names
variable "secret_name_user" {
  description = "The name for the MY_APP_USER secret."
  type        = string
  default     = "MY-APP-USER"
}

variable "secret_name_password" {
  description = "The name for the MY_APP_PASSWORD secret."
  type        = string
  default     = "MY-APP-PASSWORD"
}

variable "secret_name_url" {
  description = "The name for the MY_APP_URL secret."
  type        = string
  default     = "MY-APP-URL"
}
