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

output "acr_login_server" {
  description = "The login server of the shared Azure Container Registry"
  value       = data.azurerm_container_registry.shared.login_server
}

output "acr_id" {
  description = "The ID of the shared Azure Container Registry"
  value       = data.azurerm_container_registry.shared.id
}


# =========================================================
# Kubernetes Cluster
# =========================================================

output "aks_cluster_name" {
  value = module.aks.aks_cluster_name
}

output "aks_host" {
  value     = module.aks.aks_host
  sensitive = true
}

output "kube_config_raw" {
  value     = module.aks.kube_config_raw
  sensitive = true
}

output "key_vault_id" {
  value = module.key_vault.key_vault_id
}