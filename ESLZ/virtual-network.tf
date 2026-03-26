# -----------------------------------------------------------------------------
# MIGRATION GUIDE: v1 → v2 (ESLZ)
# -----------------------------------------------------------------------------
# Old (v1) usage — single VNet per module block:
#
#   module "Project-vnet" {
#     source            = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-virtual_network?ref=v1.1.2"
#     env               = var.env
#     userDefinedString = "${var.group}_${var.project}"
#     resource_group    = local.resource_groups_L1.Network
#     address_space     = var.network.vnet
#     dns_servers       = try(var.network.dns_servers, null)
#     encryption_enforcement = lookup(var.network, "encryption_enforcement", null)
#     tags              = var.tags
#   }
#
# New (v2 / ESLZ) usage — map-driven, one block handles all VNets:
#   - Replace the single module block above with the one below (already done here).
#   - The old `userDefinedString` argument becomes the map key in virtual_networks.
#   - The old `resource_group` (a direct resource object) becomes `resource_group`
#     (a string key referencing local.resource_groups_all).
#   - The old top-level arguments (address_space, dns_servers, etc.) move into
#     the per-entry map under virtual_networks — see virtual-network.tfvars.
#   - Remove the old `network` variable and its .tfvars entry entirely.
#
# Full upgraded example:
#
#   variable "virtual_networks" {
#     description = "Map of virtual networks to deploy. Each key becomes the userDefinedString."
#     type        = any
#     default     = {}
#   }
#
#   module "virtual-network" {
#     source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-virtual_network.git?ref=v2.0.0"
#     for_each = var.virtual_networks
#
#     userDefinedString = each.key
#     env               = var.env
#     resource_groups   = local.resource_groups_all
#     virtual_network   = each.value
#     tags              = var.tags
#   }
#
# And the corresponding virtual_networks variable in your .tfvars
# (see virtual-network.tfvars for field-by-field mapping):
#
#   virtual_networks = {
#     MyGroup_MyProject = {
#       resource_group = "Network"
#       address_space  = ["10.10.0.0/24"]
#       dns_servers    = ["10.150.17.12", "10.150.17.13"]
#     }
#   }
#
# MOVED BLOCK — prevent destroy/recreate during migration:
#   After switching to v2, add a moved block for each VNet that existed under
#   v1 so Terraform can track the state rename without replacing the resource.
#   Replace "MyGroup_MyProject" with your actual map key (the old userDefinedString
#   value), and "Project-vnet" with the old module label.
#   Once `terraform plan` shows no changes for that resource, the moved block
#   can be removed.
#
#   moved {
#     from = module.Project-vnet
#     to   = module.virtual-network["MyGroup_MyProject"]
#   }
#
#   If you had multiple VNets in separate module blocks, add one moved block per VNet:
#
#   moved {
#     from = module.Hub-vnet
#     to   = module.virtual-network["NetworkHUB"]
#   }
#
#   moved {
#     from = module.Spoke-vnet
#     to   = module.virtual-network["NetworkSpoke"]
#   }
# -----------------------------------------------------------------------------

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