# terraform-azurerm-caf-virtual_network

Deploys an Azure Virtual Network following the GC CAF naming and tagging standard.

## Usage

### ESLZ module block (`ESLZ/virtual-network.tf`)

```hcl
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
```

### ESLZ tfvars pattern (`ESLZ/virtual-network.tfvars`)

```hcl
virtual_networks = {
  NetworkHUB = {
    resource_group = "Network"              # Required: key from resource_groups map
    address_space  = ["10.10.0.0/16"]       # Required

    # dns_servers                    = ["10.10.0.4", "10.10.0.5"]
    # encryption_enforcement         = "AllowUnencrypted"
    # bgp_community                  = "12076:20000"
    # edge_zone                      = ""
    # flow_timeout_in_minutes        = 10
    # private_endpoint_vnet_policies = "Disabled"
    # ddos_protection_plan = {
    #   id     = "/subscriptions/.../ddosProtectionPlans/my-plan"
    #   enable = true
    # }
  }
}
```

## New arguments (azurerm >= 4.x)

| Key | Type | Description |
|---|---|---|
| `bgp_community` | string | BGP community attribute `<as-number>:<community-value>` |
| `edge_zone` | string | Edge Zone name within the Azure Region |
| `flow_timeout_in_minutes` | number | Connection tracking for intra-VM flows (4–30 min) |
| `private_endpoint_vnet_policies` | string | `Disabled` (default) or `Basic` |
| `ddos_protection_plan` | object | DDoS Protection Plan attachment (`id`, `enable`) |

## Testing

```bash
terraform fmt -recursive && terraform init -backend=false && terraform validate && terraform test
```

## CI

GitHub Actions workflow at `.github/workflows/test.yml` runs fmt, init, validate, and test on every PR — **no Azure credentials needed** (uses `mock_provider`).

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->


