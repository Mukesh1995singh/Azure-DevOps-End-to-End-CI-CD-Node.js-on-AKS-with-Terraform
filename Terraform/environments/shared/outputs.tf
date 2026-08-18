output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_location" {
  description = "Location of the Resource Group"
  value       = module.resource_group.resource_group_location
}

output "resource_group_id" {
  description = "ID of the Resource Group"
  value       = module.resource_group.resource_group_id
}


# =========================================================
# Shared Container Registry
# =========================================================

output "acr_id" {
  description = "ID of the shared Azure Container Registry"
  value       = module.acr.acr_id
}

output "acr_login_server" {
  description = "Login server of the shared Azure Container Registry"
  value       = module.acr.login_server
}