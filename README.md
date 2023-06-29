# terraform-azurerm-module-windows-vm
# Requirements
No requirements

# Providers
| Name          | Version       |
| ------------- | ------------- |
| azurerm       | n/a           |
| random        | n/a           |

# Modules
No Modules

# Resources
| Name                                            | type               |
| ----------------------------------------------- | ------------------ |
| azurerm_network_interface.vm_nic                      | resource           |
| azurerm_network_interface_application_security_group_association.asg  | resource |
| azurerm_network_interface_security_group_association.nsg | resource           |
| azurerm_network_security_group.nsg     | resource           |
| azurerm_network_security_rule.nsgrules| resource        |
| azurerm_network_security_rule.nsgcustomrules | resource |
| azurerm_public_ip.vm_public_ip | resouce |
| azurerm_windows_virtual_machine.azurevm | resouce |
| azurerm_virtual_machine.azurevmold | resource |
| azurerm_virtual_machine_extension.adjoin | resource |
| azurerm_virtual_machine_extension.script | resource |
| random_password.password | resource |
| azurerm_application_security_group.asgprivate | data source |
| azurerm_application_security_group.asgpublic | data source |
| azurerm_application_security_group.asgselected | data source |
| azurerm_key_vault.keyvault | data source |
| azurerm_key_vault_secret.keyvaultsecret | data source |
| azurerm_resource_group.rgname | data source |
| azurerm_subnet.selected | data source |




# Inputs
| Name                 | Description                                  |  type          | Default                                                    |  Required  |
| -------------------- | -------------------------------------------- | -------------- | ---------------------------------------------------------  | ---------- |
| azure_system_name    | The system name, e.g catalog                 | string         | n/a                                                        | yes        |
| vm_name              | This defines the name of the VM              | string         | n/a                                                        | yes        |
| vm_environment       | Environment tag, e.g prd                     | string         | n/a                                                        | yes        |
| vm_location          | This defines the location of the resource    | string         | "westeurope"                                               | no         |
| vm_old_creation      | "This is needed since there are some features in the old resource azurerm_virtual_machine(true) that are not present in the new resource azurerm_windows_virtual_machine(false)" | bool   | false | no         |
| vm_tags              | Tags to put on resources                     | map(any)       | {}                                                         | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |
| azure_users          | User list with access to the resource group. | list(string)   | "RicardoAlves1494@RicardoAlves1494hotmail.onmicrosoft.com" | no         |










# Outputs
| Name                        | Description   |
| --------------------------- | ------------- |
| azure_resource_group_id     | n/a           |
| azure_resource_group_name   | n/a           |
| azure_asg_public_name       | n/a           |
| azure_asg_public_id         | n/a           |
| azure_asg_private_name      | n/a           |
| azure_asg_private_id        | n/a           |
| azure_users_UPN             | n/a           |
