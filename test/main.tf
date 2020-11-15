terraform {
  required_version = ">= 0.12.1"
}
provider "azurerm" {
  version = ">= 2.34.0"
  features {}
}

module Project-vnet {
  source            = "../."
  env               = var.env
  userDefinedString = "test"
  resource_group    = azurerm_resource_group.test-RG
  address_space     = ["10.10.10.0/23"]
  dns_servers       = ["10.10.10.10", "10.10.10.11"]
  tags              = var.tags
}