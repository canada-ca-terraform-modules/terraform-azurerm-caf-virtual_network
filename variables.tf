variable "env" {
  description = "You can use a prefix to add to the list of resource groups you want to create"
  type        = string
}

variable "maxLength" {
  description = "Maximum length of the resource name generated"
  default = 64
  type    = number
}

variable "userDefinedString" {
  description = "UserDefinedString part of the name of the resource"
  type        = string
}

variable "address_space" {
  description = "List of networks for the vnet"
  type        = list(string)
}

variable "dns_servers" {
  description = "List of IP addresses of DNS servers"
  type        = list(string)
  default     = null
}

variable "vm_protection_enabled" {
  description = "Whether to enable VM protection for all the subnets in this Virtual Network"
  type        = bool
  default     = false
}

variable "resource_group" {
  description = "Resource group object of the AKV to be created"
  type        = any
}

variable "tags" {
  description = "Tags to be applied to the AKV to be created"
  type        = map(string)
}
