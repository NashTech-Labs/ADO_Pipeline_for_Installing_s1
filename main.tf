data "azurerm_virtual_machine" "vms" {
  count = length(var.vm_names)
  name                = var.vm_names[count.index]
  resource_group_name = var.resource_group
}

# data "azurerm_virtual_machine" "vms" {
#   name                = "production"
#   resource_group_name = var.resource_group
# }


resource "azurerm_virtual_machine_extension" "sentinelone" {
  count = length(data.azurerm_virtual_machine.vms)
  name                       = "WindowsExtension"
  virtual_machine_id         = data.azurerm_virtual_machine.vms[count.index].id
  publisher                  = "SentinelOne.WindowsExtension"
  type                       = "WindowsExtension"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = false
  timeouts {
    create = "60m"
    delete = "120m"
  }

  provisioner "local-exec" {
    command     = "echo 'SentinelOne finished'"
    on_failure = continue
    when = create
  }

  settings = <<SETTINGS
    {
      "SiteToken": "${var.sentinel_token}",
      "WindowsAgentVersion": "23.3.3.264"      
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "SentinelOneConsoleAPIKey":"${var.sentinel_apikey}"
    }
PROTECTED_SETTINGS

}
