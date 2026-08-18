# ============================================================
# AKS Outputs
# ============================================================

output "aks_id" {
  description = "Resource ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.app-aks.id
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.app-aks.name
}

output "aks_host" {
  description = "API server host of the AKS cluster"
  value       = azurerm_kubernetes_cluster.app-aks.kube_config[0].host
  sensitive   = true
}

output "kube_config_raw" {
  description = "Raw kubeconfig for the AKS cluster"
  value       = azurerm_kubernetes_cluster.app-aks.kube_config_raw
  sensitive   = true
}

output "aks_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = azurerm_kubernetes_cluster.app-aks.fqdn
}

output "aks_kubelet_identity_object_id" {
  description = "Object ID of the AKS kubelet managed identity"
  value       = azurerm_kubernetes_cluster.app-aks.kubelet_identity[0].object_id
}

# ============================================================
# Workload Identity / Key Vault
# ============================================================

output "key_vault_identity_client_id" {
  description = "Client ID of the User Assigned Managed Identity used for Key Vault"
  value       = azurerm_user_assigned_identity.key_vault.client_id
}

output "key_vault_identity_principal_id" {
  description = "Principal ID of the User Assigned Managed Identity used for Key Vault"
  value       = azurerm_user_assigned_identity.key_vault.principal_id
}

output "key_vault_identity_id" {
  description = "Resource ID of the User Assigned Managed Identity used for Key Vault"
  value       = azurerm_user_assigned_identity.key_vault.id
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL of the AKS cluster"
  value       = azurerm_kubernetes_cluster.app-aks.oidc_issuer_url
}