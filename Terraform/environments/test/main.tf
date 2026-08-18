# =========================================================
# Resource Group
# =========================================================

module "resource_group" {
  source = "../../modules/resource-group"

  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags
}


# =========================================================
# Networking
# =========================================================

module "network" {
  source = "../../modules/networking"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  vnet_name    = var.vnet_name
  vnet_address = var.vnet_address
  subnets      = var.subnets
  tags         = var.tags

  depends_on = [
    module.resource_group
  ]
}


# =========================================================
# Shared ACR
# =========================================================

data "azurerm_container_registry" "shared" {
  name                = var.shared_acr_name
  resource_group_name = var.shared_acr_resource_group_name
}


# =========================================================
# AKS
# =========================================================

module "aks" {
  source = "../../modules/aks"

  resource_group_name = module.resource_group.resource_group_name
  location            = var.location

  aks_name           = var.aks_name
  dns_prefix         = var.dns_prefix
  kubernetes_version = var.kubernetes_version
  node_count         = var.node_count
  vm_size            = var.vm_size

  vnet_subnet_id = module.network.subnet_ids["aks-test"]
  key_vault_id   = module.key_vault.key_vault_id
  acr_id         = data.azurerm_container_registry.shared.id

  tags = var.tags

  depends_on = [
    module.resource_group,
    module.network
  ]
}


# =========================================================
# NGINX Ingress
# =========================================================

module "nginx_ingress" {
  source = "../../modules/nginx-ingress"

  chart_version = var.nginx_chart_version

  depends_on = [
    module.aks
  ]
}

# ============================================================
# Azure Client Configuration
# ============================================================

data "azurerm_client_config" "current" {}


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

  db_host               = var.db_host
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  mongodb_root_username = var.mongodb_root_username
  mongodb_root_password = var.mongodb_root_password

  tags = var.tags
}