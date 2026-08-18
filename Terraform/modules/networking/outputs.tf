output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.app-vnet.id
}

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.app-vnet.name
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  value       = { for k, v in azurerm_subnet.subnets : k => v.id }
}