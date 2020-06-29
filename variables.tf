# Example of resource_groups data structure:
# resource_groups = {
#   apim          = { 
#                     userDefinedString = "apim-demo"
#                   },
#   networking    = {    
#                     userDefinedString = "networking-demo"
#                     location          = "southeastasia"
#                     tags              = {
#                                           special = "special-location-needed"
#                                         }  
#                   },
#   insights      = { 
#                     userDefinedString = "insights-demo" 
#                   },
# }

variable "env" {
  description = "(Required) You can use a prefix to add to the list of resource groups you want to create"
}

variable "address_space" {
  description = "List of networks for the vnet"
}

variable "resource_group" {
  description = "(Required) Resource group object of the AKV to be created"
}

variable "tags" {
  description = "(Required) Tags to be applied to the AKV to be created"
}

variable "maxLength" {
  default = 64
  type    = number
}

variable "userDefinedString" {
  description = "(Required) UserDefinedString part of the name of the resource"
  type        = string
}