terraform {
  required_version = ">= 0.12.1"
}
provider "azurerm" {
  version = ">= 1.32.0"
  features {}
}

resource "azurerm_virtual_network" "test-VNET" {
  name                = "test-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.test-RG.name
  address_space       = ["10.10.10.0/23"]
  dns_servers         = ["10.10.10.10", "10.10.10.11"]
}