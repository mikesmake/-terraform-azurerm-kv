#key-vault
##Purpose
This module is to manage an Azure Key vault

##Usage
Use this module to manage an Azure key vault as part of a larger composition
###Examples

####Simple key vault module usage
```
module "key_vault_1" {
    source = "./key-vault"
    resource_group_name = "rg"
	key_vault_name = "key_vault_1"
}
```

####Key vault usage without terraform access policy
```
module "key_vault_1" {
    source = "./key-vault"
	resource_group_name = "rg"
    create_terraform_access_policy = false
    key_vault_name = "Key_vault_1"
}
```

##External Dependencies
1. An Azure Resource Group
