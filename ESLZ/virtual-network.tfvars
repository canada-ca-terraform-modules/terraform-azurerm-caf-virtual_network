# Example values for the legacy module call pattern.
# See virtual-network.tf for the full module block.

# network = {
#   vnet        = ["10.10.0.0/16"]
#   dns_servers = ["10.10.0.4", "10.10.0.5"]
#
#   # New in v2.0.0 — all optional
#   # encryption_enforcement         = "AllowUnencrypted"
#   # bgp_community                  = "12076:20000"
#   # flow_timeout_in_minutes        = 10
#   # private_endpoint_vnet_policies = "Basic"
#   # ddos_protection_plan = {
#   #   id     = "/subscriptions/.../ddosProtectionPlans/my-plan"
#   #   enable = true
#   # }
# }
