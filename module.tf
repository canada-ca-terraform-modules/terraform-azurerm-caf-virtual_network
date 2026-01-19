resource azurerm_virtual_network vnet {
  name                  = local.name
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  address_space         = var.address_space
  dns_servers           = var.dns_servers
  tags                  = local.tags

  dynamic "encryption" {
    for_each = var.encryption_enforcement != null ? [var.encryption_enforcement] : []
    content {
      enforcement = encryption.value
    }
  }
}
