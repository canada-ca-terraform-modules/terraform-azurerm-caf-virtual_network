# Deploys an Azure VNET

Creates an Azure VNET.

Reference the module to a specific version (recommended):

```hcl
module Project-vnet {
  source            = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-virtual_network?ref=v1.1.0"
  env               = var.env
  userDefinedString = "${var.group}_${var.project}"
  resource_group    = local.resource_groups_L1.Network
  address_space     = var.network.vnet
  tags              = var.tags
}

locals {
  Project-vnet = module.Project-vnet.virtual_network
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| azurerm | >= 1.32.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 1.32.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_space | List of networks for the vnet | `list(string)` | n/a | yes |
| env | You can use a prefix to add to the list of resource groups you want to create | `string` | n/a | yes |
| resource\_group | Resource group object of the AKV to be created | `any` | n/a | yes |
| tags | Tags to be applied to the AKV to be created | `map(string)` | n/a | yes |
| userDefinedString | UserDefinedString part of the name of the resource | `string` | n/a | yes |
| dns\_servers | List of IP addresses of DNS servers | `list(string)` | `null` | no |
| maxLength | Maximum length of the resource name generated | `number` | `64` | no |
| vm\_protection\_enabled | Whether to enable VM protection for all the subnets in this Virtual Network | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| virtual\_network | Returns the virtual\_network object created |

