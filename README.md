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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | List of address prefixes for the VNet (legacy; use virtual\_network.address\_space) | `list(string)` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of DNS server IP addresses (legacy; use virtual\_network.dns\_servers) | `list(string)` | `null` | no |
| <a name="input_encryption_enforcement"></a> [encryption\_enforcement](#input\_encryption\_enforcement) | Encryption enforcement for the VNet (legacy; use virtual\_network.encryption\_enforcement) | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | (Required) Environment prefix used in the CAF naming convention (e.g. Dev, Prod, ScTc) | `string` | n/a | yes |
| <a name="input_maxLength"></a> [maxLength](#input\_maxLength) | Maximum length of the resource name generated (legacy; unchanged default 64) | `number` | `64` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group object (legacy; use virtual\_network.resource\_group + resource\_groups) | `any` | `null` | no |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | Map of resource group objects keyed by logical name (name, location, id) | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |
| <a name="input_userDefinedString"></a> [userDefinedString](#input\_userDefinedString) | (Required) UserDefinedString portion of the resource name | `string` | n/a | yes |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | (Required) Virtual network configuration object. See ESLZ/virtual-network.tfvars for all supported keys. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_network"></a> [virtual\_network](#output\_virtual\_network) | Returns the virtual\_network object created |
<!-- END_TF_DOCS -->


