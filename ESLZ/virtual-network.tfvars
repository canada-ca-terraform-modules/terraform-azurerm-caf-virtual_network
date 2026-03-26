# -----------------------------------------------------------------------------
# MIGRATION GUIDE: v1 → v2 (ESLZ)
# -----------------------------------------------------------------------------
# Old (v1) .tfvars — a flat `network` object:
#
#   network = {
#     vnet        = ["VNETIP.0/24"]
#     dns_servers = ["10.150.17.12", "10.150.17.13"]
#   }
#
# Migration steps:
#   1. Delete the old `network = { ... }` block from your .tfvars.
#   2. Add a `virtual_networks` map entry below.
#   3. Use the old userDefinedString value (e.g. "${group}_${project}") as the map key.
#   4. Move `network.vnet`        → address_space  (list of CIDR strings)
#      Move `network.dns_servers` → dns_servers     (list of IP strings, keep commented if unused)
#      Move `resource_group`      → resource_group  (string key into resource_groups_all)
#
#   Before:
#     network = {
#       vnet        = ["10.10.0.0/24"]
#       dns_servers = ["10.150.17.12", "10.150.17.13"]
#     }
#
#   After:
#     virtual_networks = {
#       MyGroup_MyProject = {              # was: userDefinedString = "${var.group}_${var.project}"
#         resource_group = "Network"      # was: resource_group = local.resource_groups_L1.Network
#         address_space  = ["10.10.0.0/24"]  # was: network.vnet
#         dns_servers    = ["10.150.17.12", "10.150.17.13"]  # was: network.dns_servers
#       }
#     }
# -----------------------------------------------------------------------------

virtual_networks = {
  NetworkHUB = {                      # Key becomes the userDefinedString in the name
    resource_group = "Network"        # Required: key from resource_groups map
    address_space  = ["10.10.0.0/16"] # Required: one or more CIDR prefixes

    # dns_servers = ["10.10.0.4", "10.10.0.5"]  # Optional: custom DNS servers

    # Optional: VNet-level encryption (AllowUnencrypted is currently the only GA value)
    # encryption_enforcement = "AllowUnencrypted"

    # Optional: BGP community — format "<as-number>:<community-value>" (MS ASN is always 12076)
    # bgp_community = "12076:20000"

    # Optional: Edge Zone name within the Azure Region
    # edge_zone = ""

    # Optional: connection tracking for intra-VM flows (4–30 minutes)
    # flow_timeout_in_minutes = 10

    # Optional: Private Endpoint VNet Policies — "Disabled" (default) or "Basic"
    # private_endpoint_vnet_policies = "Disabled"

    # Optional: DDoS Protection Plan attachment
    # ddos_protection_plan = {
    #   id     = "/subscriptions/.../resourceGroups/.../providers/Microsoft.Network/ddosProtectionPlans/my-plan"
    #   enable = true
    # }
  }
}