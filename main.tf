terraform {
  required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          #Ensure this is set appropriately, based on the provider version used when constructing the module
          # IE ">=2.44.0" for "any version of 2.44.0 or above"
          version = ">=2.44.0"
      }
  }
}

/*
    START data providers
*/

#To get the current session details
data "azurerm_client_config" "current" {}

#Creates a data reference for the target resource group
data "azurerm_resource_group" "resource_group" {
    name = var.resource_group_name
}

/*
    END data providers
*/

/*
    START resource providers
*/

resource "azurerm_key_vault" "key_store" {
    name = var.key_vault_name
    location = data.azurerm_resource_group.resource_group.location
    resource_group_name = data.azurerm_resource_group.resource_group.name
    enabled_for_disk_encryption = true
    tenant_id = data.azurerm_client_config.current.tenant_id
    soft_delete_retention_days = 7
    purge_protection_enabled = false
    sku_name = var.sku_name
}

resource "azurerm_key_vault_access_policy" "tf_deployment_access_policy" {
    #Only create the resource if the flag "create_terraform_access_policy" has been set to true
    count = var.create_terraform_access_policy ? 1 : 0

    key_vault_id = azurerm_key_vault.key_store.id
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
        "create",
        "get",
    ]

    secret_permissions = [
        "set",
        "get",
        "delete",
        "purge",
        "recover",
        "list"
    ]

    depends_on = [azurerm_key_vault.key_store]
}

/*
    END resource providers
*/