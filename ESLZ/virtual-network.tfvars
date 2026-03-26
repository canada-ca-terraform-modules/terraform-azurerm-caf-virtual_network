virtual_networks = {
  NetworkHUB = {                      # Key becomes the userDefinedString in the name
    resource_group = "Network"        # Required: key from resource_groups map
    address_space  = ["10.10.0.0/16"] # Required: one or more CIDR prefixes

    # dns_servers = ["10.10.0.4", "10.10.0.5"]  # Optional: custom DNS servers

    # Optional: VNet-level encryption (AllowUnencrypted is currently the only GA value)
    # encryption_enforcement = "AllowUnencrypted"

    # Optional: enable VM protection for all subnets
    # vm_protection_enabled = false

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
