locals {
  tenant_id = get_env("ARM_TENANT_ID")
}
generate "versions" {
  path = "versions.tf"
 
  if_exists = "overwrite_terragrunt"
 
  contents = <<EOF
terraform { 
  required_version = ">= 1.10.5"
 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.21.1"
    }
  }
}

EOF
}

generate "provider" {
  path = "providers.tf"
 
  if_exists = "overwrite_terragrunt"
 
  contents = <<EOF
provider "azurerm" { 
  features {}
  subscription_id = "2b69f314-9a87-4be7-aafd-b422c84d7b11"
}
EOF
}

remote_state {
  backend = "azurerm"
  config = {
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    storage_account_name = get_env("TF_STORAGE_ACCOUNT_NAME")
    container_name       = get_env("TF_STORAGE_CONTAINER_NAME")
    access_key           = get_env("TF_STORAGE_ACCESS_KEY")
  }
}
