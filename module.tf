resource "azurerm_virtual_network" "vnet" {
  name                           = local.name
  location                       = local.resource_group_obj.location
  resource_group_name            = local.resource_group_obj.name
  address_space                  = local.address_space
  dns_servers                    = local.dns_servers
  bgp_community                  = local.bgp_community
  edge_zone                      = local.edge_zone
  flow_timeout_in_minutes        = local.flow_timeout_in_minutes
  private_endpoint_vnet_policies = local.private_endpoint_vnet_policies
  tags                           = local.tags

  dynamic "encryption" {
    for_each = local.encryption_enforcement != null ? [local.encryption_enforcement] : []
    content {
      enforcement = encryption.value
    }
  }

  dynamic "ddos_protection_plan" {
    for_each = local.ddos_protection_plan != null ? [local.ddos_protection_plan] : []
    content {
      id     = ddos_protection_plan.value["id"]
      enable = ddos_protection_plan.value["enable"]
    }
  }
}
