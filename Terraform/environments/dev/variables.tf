# ============================================================
# Resource Group
# ============================================================

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}


# ============================================================
# Networking
# ============================================================

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
}

variable "vnet_address" {
  description = "Virtual network address space"
  type        = list(string)
}

variable "subnets" {
  description = "Subnet configuration"

  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "aks_subnet_name" {
  description = "Name of the subnet used by AKS"
  type        = string
}


# ============================================================
# AKS
# ============================================================

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "dns_prefix" {
  description = "AKS DNS prefix"
  type        = string
}

variable "node_pool_name" {
  description = "AKS default node pool name"
  type        = string
  default     = "system"
}

variable "node_count" {
  description = "Initial AKS node count"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "AKS node VM size"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
  default     = null
}


# ============================================================
# Shared ACR
# ============================================================

variable "shared_acr_name" {
  description = "Shared Azure Container Registry name"
  type        = string
}

variable "shared_acr_resource_group_name" {
  description = "Resource group containing the shared ACR"
  type        = string
}


# ============================================================
# NGINX Ingress
# ============================================================

variable "nginx_chart_version" {
  description = "NGINX Ingress Helm chart version"
  type        = string
  default     = "4.15.1"
}


# ============================================================
# Key Vault
# ============================================================

variable "key_vault_name" {
  description = "Azure Key Vault name"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "terraform_principal_object_id" {
  description = "Object ID of the Terraform Service Principal"
  type        = string
}


# ============================================================
# MongoDB Connection Details
# ============================================================

variable "db_host" {
  description = "MongoDB host"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "MongoDB database name"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "MongoDB username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "MongoDB password"
  type        = string
  sensitive   = true
}

variable "mongodb_root_username" {
  description = "MongoDB root username"
  type        = string
  sensitive   = true
}

variable "mongodb_root_password" {
  description = "MongoDB root password"
  type        = string
  sensitive   = true
}


# ============================================================
# AKS Workload Identity
# ============================================================

variable "workload_identity_namespace" {
  description = "Kubernetes namespace for the workload identity"
  type        = string
}

variable "workload_identity_service_account" {
  description = "Kubernetes ServiceAccount for the workload identity"
  type        = string
}