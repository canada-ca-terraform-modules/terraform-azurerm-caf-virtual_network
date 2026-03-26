locals {
  # ---------------------------------------------------------------------------
  # Resource group resolution
  # ESLZ path:   virtual_network.resource_group is a key into var.resource_groups
  # Legacy path: var.resource_group is the resource group object directly
  # ---------------------------------------------------------------------------
  resource_group_obj = try(
    var.resource_groups[var.virtual_network.resource_group],
    var.resource_group
  )

  # ---------------------------------------------------------------------------
  # Network config: ESLZ config object takes precedence, legacy vars as fallback
  # ---------------------------------------------------------------------------
  address_space                  = try(var.virtual_network.address_space, var.address_space)
  dns_servers                    = try(var.virtual_network.dns_servers, var.dns_servers, null)
  encryption_enforcement         = try(var.virtual_network.encryption_enforcement, var.encryption_enforcement, null)
  bgp_community                  = try(var.virtual_network.bgp_community, null)
  edge_zone                      = try(var.virtual_network.edge_zone, null)
  flow_timeout_in_minutes        = try(var.virtual_network.flow_timeout_in_minutes, null)
  private_endpoint_vnet_policies = try(var.virtual_network.private_endpoint_vnet_policies, null)
  ddos_protection_plan           = try(var.virtual_network.ddos_protection_plan, null)
}
