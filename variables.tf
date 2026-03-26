variable "env" {
  description = "(Required) Environment prefix used in the CAF naming convention (e.g. Dev, Prod, ScTc)"
  type        = string
}

variable "userDefinedString" {
  description = "(Required) UserDefinedString portion of the resource name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "resource_groups" {
  description = "Map of resource group objects keyed by logical name (name, location, id)"
  type        = any
  default     = {}
}

variable "virtual_network" {
  description = "(Required) Virtual network configuration object. See ESLZ/virtual-network.tfvars for all supported keys."
  type        = any
  default     = {}
}

# ---------------------------------------------------------------------------
# Legacy variables — kept for backward compatibility; prefer virtual_network.xxx
# ---------------------------------------------------------------------------

variable "maxLength" {
  description = "Maximum length of the resource name generated (legacy; unchanged default 64)"
  type        = number
  default     = 64
}

variable "address_space" {
  description = "List of address prefixes for the VNet (legacy; use virtual_network.address_space)"
  type        = list(string)
  default     = null
}

variable "dns_servers" {
  description = "List of DNS server IP addresses (legacy; use virtual_network.dns_servers)"
  type        = list(string)
  default     = null
}

variable "resource_group" {
  description = "Resource group object (legacy; use virtual_network.resource_group + resource_groups)"
  type        = any
  default     = null
}

variable "encryption_enforcement" {
  description = "Encryption enforcement for the VNet (legacy; use virtual_network.encryption_enforcement)"
  type        = string
  default     = null
}