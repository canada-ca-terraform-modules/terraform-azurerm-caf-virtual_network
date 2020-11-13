terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = ">= 2.36.0"
  }
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)
}