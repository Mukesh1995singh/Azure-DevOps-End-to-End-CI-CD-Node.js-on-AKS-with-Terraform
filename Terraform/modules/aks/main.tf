data "azurerm_client_config" "current" {}


# ============================================================
# AKS Cluster
# ============================================================

resource "azurerm_kubernetes_cluster" "app-aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name           = var.node_pool_name
    vm_size        = var.vm_size
    node_count     = var.node_count
    vnet_subnet_id = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  node_provisioning_profile {
    mode = "Manual"
  }

  # ==========================================================
  # Workload Identity
  # ==========================================================

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  # ==========================================================
  # Azure RBAC for Kubernetes
  # ==========================================================

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
    tenant_id          = data.azurerm_client_config.current.tenant_id
  }

  # ==========================================================
  # Network
  # ==========================================================

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = var.tags
}


# ============================================================
# ACR Pull Permission
# ============================================================

resource "azurerm_role_assignment" "acr-pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.app-aks.kubelet_identity[0].object_id
}


# ============================================================
# User Assigned Managed Identity
# Used by AKS workloads to access Key Vault
# ============================================================

resource "azurerm_user_assigned_identity" "key_vault" {
  name                = "${var.aks_name}-keyvault-identity"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}


# ============================================================
# Key Vault Permission
# User Assigned Identity can read Key Vault secrets
# ============================================================

resource "azurerm_role_assignment" "key_vault_secrets_user" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.key_vault.principal_id
}


# ============================================================
# Federated Identity Credential
# ============================================================

resource "azurerm_federated_identity_credential" "key_vault" {
  name = "${var.aks_name}-keyvault-federation"

  user_assigned_identity_id = azurerm_user_assigned_identity.key_vault.id

  issuer = azurerm_kubernetes_cluster.app-aks.oidc_issuer_url

  subject = "system:serviceaccount:${var.workload_identity_namespace}:${var.workload_identity_service_account}"

  audience = [
    "api://AzureADTokenExchange"
  ]
}