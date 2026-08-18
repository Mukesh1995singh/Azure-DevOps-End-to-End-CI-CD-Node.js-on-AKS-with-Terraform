# ============================================================
# Azure Client Configuration
# ============================================================

data "azurerm_client_config" "current" {}


# ============================================================
# Resource Group
# ============================================================

module "resource_group" {
  source = "../../modules/resource-group"

  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags
}


# ============================================================
# Networking
# ============================================================

module "network" {
  source = "../../modules/networking"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  vnet_name    = var.vnet_name
  vnet_address = var.vnet_address
  subnets      = var.subnets

  tags = var.tags

  depends_on = [
    module.resource_group
  ]
}


# ============================================================
# Shared ACR
# ============================================================

data "azurerm_container_registry" "shared" {
  name                = var.shared_acr_name
  resource_group_name = var.shared_acr_resource_group_name
}


# ============================================================
# Key Vault
# ============================================================

module "key_vault" {
  source = "../../modules/key-vault"

  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  tenant_id           = var.tenant_id

  terraform_principal_object_id = var.terraform_principal_object_id

  # MongoDB secrets
  db_host               = var.db_host
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  mongodb_root_username = var.mongodb_root_username
  mongodb_root_password = var.mongodb_root_password

  tags = var.tags

  depends_on = [
    module.resource_group
  ]
}


# ============================================================
# AKS
# ============================================================

module "aks" {
  source = "../../modules/aks"

  aks_name            = var.aks_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  # Node Pool
  node_pool_name = var.node_pool_name
  vm_size        = var.vm_size
  node_count     = var.node_count

  # Networking
  vnet_subnet_id = module.network.subnet_ids[var.aks_subnet_name]

  # ACR
  acr_id = data.azurerm_container_registry.shared.id

  # Key Vault
  key_vault_id = module.key_vault.key_vault_id

  # Workload Identity
  workload_identity_namespace       = var.workload_identity_namespace
  workload_identity_service_account = var.workload_identity_service_account

  tags = var.tags

  depends_on = [
    module.network,
    module.key_vault
  ]
}


# ============================================================
# NGINX Ingress
# ============================================================

module "nginx_ingress" {
  source = "../../modules/nginx-ingress"

  chart_version = var.nginx_chart_version

  depends_on = [
    module.aks
  ]
}