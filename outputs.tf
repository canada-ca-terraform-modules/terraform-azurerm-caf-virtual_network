output "virtual_network" {
  description = "Returns the virtual_network object created"
  sensitive   = true
  value       = azurerm_virtual_network.vnet
}