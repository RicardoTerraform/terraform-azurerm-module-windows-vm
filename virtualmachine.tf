resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "#$%*-_=+:"
}


resource "azurerm_windows_virtual_machine" "azurevm" {
  count = var.vm_old_creation ? 0 : 1

  name                = "${var.azure_system_name}-${var.vm_name}-${var.vm_environment}"
  computer_name       = length("${var.azure_system_name}-${var.vm_name}-${var.vm_environment}") > 15 ? "${var.vm_name}" : "${var.azure_system_name}-${var.vm_name}-${var.vm_environment}"
  resource_group_name = data.azurerm_resource_group.rgname.name
  location            = var.vm_location

  size                  = var.vm_instance_type
  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  source_image_id = var.vm_image_id
  dynamic "source_image_reference" {
    for_each = var.vm_image_id == null ? ["true"] : []

    content {
      publisher = var.vm_image["publisher"]
      offer     = var.vm_image["offer"]
      sku       = var.vm_image["sku"]
      version   = var.vm_image["version"]
    }

    #for_each = var.vm_image_id == null ? [var.vm_image] : []
    # content {
    #   publisher = source_image_reference.value["publisher"]
    #   offer     = source_image_reference.value["offer"]
    #   sku       = source_image_reference.value["sku"]
    #   version   = source_image_reference.value["version"]
    # }
  }

  #availability_set_is = 
  zone = var.vm_Avail_zone_id

  #Storage account where the boot diagnostics will be saved
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  os_disk {
    name                 = "${var.azure_system_name}-${var.vm_name}-osdisk-${var.vm_environment}"
    caching              = var.vm_os_disk_caching
    storage_account_type = var.vm_os_disk_storage_account_type
    disk_size_gb         = var.vm_os_disk_size_gb
  }

  #About VM Spot - we can turn it true to dev VM - sem SLA mas podemos poupar dinheiro
  priority        = var.vm_spot_instance ? "Spot" : "Regular"
  max_bid_price   = var.vm_spot_instance ? var.vm_spot_instance_max_bid_price : null
  eviction_policy = var.vm_spot_instance ? var.vm_spot_instance_eviction_policy : null

  #About update management
  patch_mode            = var.vm_patch_mode
  patch_assessment_mode = var.vm_patch_mode == "AutomaticByPlatform" ? var.vm_patch_mode : "ImageDefault"

  admin_username = var.vm_admin_username
  admin_password = var.vm_admin_password == null ? random_password.password.result : var.vm_admin_password

  #Managed identity turn on - VM can access storage account/secrets/password - we do not need to expose secrets
  dynamic "identity" {
    for_each = var.vm_managed_identity != null ? ["true"] : []
    content {
      type         = var.vm_managed_identity.type
      identity_ids = var.vm_managed_identity.identity_ids
    }
  }

  #user_data = "${data.template_cloudinit_config.config.rendered}"

  tags       = merge(var.vm_tags, local.tags_default)
  depends_on = [azurerm_network_interface.vm_nic]
}




resource "azurerm_virtual_machine" "azurevmold" {
  count = var.vm_old_creation ? 1 : 0

  name                = "${var.azure_system_name}-${var.vm_name}-${var.vm_environment}"
  resource_group_name = data.azurerm_resource_group.rgname.name
  location            = var.vm_location

  vm_size               = var.vm_instance_type
  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  #availability_set_id = 

  boot_diagnostics {
    enabled     = var.boot_diagnostics_storage_account_uri != null
    storage_uri = var.boot_diagnostics_storage_account_uri
  }

  dynamic "identity" {
    for_each = var.vm_managed_identity != null ? ["true"] : []
    content {
      type         = var.vm_managed_identity.type
      identity_ids = var.vm_managed_identity.identity_ids
    }
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }


  storage_os_disk {
    name            = "${var.azure_system_name}-${var.vm_name}-osdisk-${var.vm_environment}"
    create_option   = "Attach"
    os_type         = "Windows"
    managed_disk_id = var.vm_os_disk_id
    disk_size_gb    = var.vm_os_disk_size_gb
  }

  dynamic "storage_image_reference" {
    for_each = var.vm_image_id == null ? ["true"] : []

    content {
      publisher = var.vm_image["publisher"]
      offer     = var.vm_image["offer"]
      sku       = var.vm_image["sku"]
      version   = var.vm_image["version"]
    }
  }
  ###############################################




  # os_profile {
  #   computer_name  = "hostname"
  #   admin_username = "testadmin"
  #   admin_password = "Password1234!"
  # }

  # os_profile_linux_config {
  #   disable_password_authentication = false
  # }
  tags = merge(var.vm_tags, local.tags_default)

}


resource "azurerm_virtual_machine_extension" "adjoin" {

  count = var.vm_join_ad ? 1 : 0

  name                       = "VMADJOIN"
  virtual_machine_id         = local.ids
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = <<-SETTINGS
{
 "Name": "${local.domain}",
 "Restart": "True",
 "options": "3",
 "User": "${local.join_ad_user}" 
}
SETTINGS

  protected_settings = <<-SETTINGS
{
  "Password": "${data.azurerm_key_vault_secret.keyvaultsecret.value}"
}
SETTINGS

}



# resource "azurerm_virtual_machine_extension" "script" {
#   name                 = "script"
#   virtual_machine_id   = local.ids
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "2.0"
#   auto_upgrade_minor_version = true

#   settings = <<SETTINGS
#  {
#    "commandToExecute": "powershell -command -File ${path.module}/scripts/test.sh"
#  }
# SETTINGS

# }

#"commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File start.ps1"

#"script": "${filebase64("${path.module}/scripts/test.sh")}"