variable "resource_group_name" {
    type = string
    description = "Name of an externally managed resource group"
}

variable "sku_name" {
    type = string
    default = "standard"
    description = "The sku of the key vault"
}

variable "create_terraform_access_policy" {
    type = bool
    default = true
    description = "Give the current context access to the keyvault? (Uses current authentication to find the user account / principal to add)"
}

variable "key_vault_name" {
    type = string
    description = "The name of the key vault to manage"
}