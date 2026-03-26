variable "virtual_networks" {
  description = "Map of virtual networks to deploy. Each key becomes the userDefinedString."
  type        = any
  default     = {}
}

module "virtual-network" {
  source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-virtual_network.git?ref=v2.0.0"
  for_each = var.virtual_networks

  userDefinedString = each.key
  env               = var.env
  resource_groups   = local.resource_groups_all
  virtual_network   = each.value
  tags              = var.tags
}
