# Upgrade guide: v1.x → v2.0.0
#
# Only change needed is the ?ref= version. All existing variables and tfvars
# are accepted as-is via backward-compat fallbacks in locals.tf.
# No resource destroy+recreate — the resource address does not change.
#
#   module "Project-vnet" {
#     source            = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-virtual_network?ref=v2.0.0"
#     env               = var.env
#     userDefinedString = "${var.group}_${var.project}"
#     resource_group    = local.resource_groups_all.Network
#     address_space     = var.network.vnet
#     dns_servers       = try(var.network.dns_servers, null)
#     encryption_enforcement = lookup(var.network, "encryption_enforcement", null)
#     tags              = var.tags
#   }
#
# New optional arguments available in v2.0.0 (pass directly on the module block):
#
#   bgp_community                  = "12076:20000"
#   edge_zone                      = ""
#   flow_timeout_in_minutes        = 10
#   private_endpoint_vnet_policies = "Basic"
#   ddos_protection_plan = {
#     id     = "/subscriptions/.../ddosProtectionPlans/my-plan"
#     enable = true
#   }

# =============================================================================
# Optional: migrate to the virtual_network config object tfvars structure
# =============================================================================
#
# If you want to adopt the new tfvars structure, replace the flat module args
# with a virtual_network object and update the module block as shown below.
#
# ⚠️  The resource address changes from module.Project-vnet to
#     module.virtual-network["<key>"], which would cause destroy+recreate.
#     Add the moved block below BEFORE running terraform apply.
#
# 1. Add to your root module:
#
#   variable "virtual_networks" {
#     type    = any
#     default = {}
#   }
#
#   moved {
#     from = module.Project-vnet.azurerm_virtual_network.vnet
#     to   = module.virtual-network["${var.group}_${var.project}"].azurerm_virtual_network.vnet
#   }
#
#   module "virtual-network" {
#     source   = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-virtual_network?ref=v2.0.0"
#     for_each = var.virtual_networks
#
#     env               = var.env
#     userDefinedString = each.key
#     resource_group    = local.resource_groups_all.Network
#     virtual_network   = each.value
#     tags              = var.tags
#   }
#
# 2. Replace your tfvars with the new structure (see virtual-network.tfvars):
#
#   virtual_networks = {
#     "<group>_<project>" = {          # same value as the old userDefinedString
#       address_space          = ["10.10.0.0/16"]
#       dns_servers            = ["10.10.0.4", "10.10.0.5"]
#       encryption_enforcement = "AllowUnencrypted"  # if applicable
#     }
#   }
#
# 3. Run terraform plan — expected: 0 to add, 0 to destroy (only state rename).
#    Once confirmed, remove the moved block on the next commit.

