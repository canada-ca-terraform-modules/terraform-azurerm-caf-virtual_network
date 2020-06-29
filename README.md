# Deploys an Azure VNET

Creates an Azure VNET.

Reference the module to a specific version (recommended):

```hcl
module Project-vnet {
  source            = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-virtual_network?ref=v1.0.0"
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

## Inputs

| Name              | Type   | Default | Description                                                                                                       |
| ----------------- | ------ | ------- | ----------------------------------------------------------------------------------------------------------------- |
| resource_group    | object | None    | (Required) Resource group object where to create the resource. Changing this forces a new resource to be created. |
| tags              | map    | None    | (Required) Map of tags for the deployment.                                                                        |
| max_length        | string | None    | (Optional) maximum length to the name of the resource.                                                            |
| env               | string | None    | (Required) You can use a prefix to add to the list of resource groups you want to create                          |
| userDefinedString | string | None    | (Required) UserDefinedString part of the name of the resource                                                     |
| address_space     | list   | None    | (Required) List of networks for the vnet                                                                          |

## Output

| Name            | Type   | Description                                  |
| --------------- | ------ | -------------------------------------------- |
| virtual_network | object | Returns the full object of the created VNET. |
