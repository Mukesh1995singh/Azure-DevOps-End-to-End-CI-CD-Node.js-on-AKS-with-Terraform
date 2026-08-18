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
  description = "The name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "aks_host" {
  description = "The Kubernetes API server host endpoint"
  value       = module.aks.host
  sensitive   = true
}

output "kube_config_raw" {
  description = "Raw Kubernetes config to authenticate to the cluster"
  value       = module.aks.kube_config_raw
  sensitive   = true
}

output "key_vault_id" {
  value = azurerm_key_vault.this.id
}