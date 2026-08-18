variable "aks_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "vnet_subnet_id" {
  type = string
}

variable "acr_id" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "node_count" {
  type = number
}

variable "node_pool_name" {
  type    = string
  default = "system"
}

variable "tags" {
  type = map(string)
}

# ============================================================
# Key Vault
# ============================================================

variable "key_vault_id" {
  description = "Resource ID of the Azure Key Vault"
  type        = string
}

# ============================================================
# Workload Identity
# ============================================================

variable "workload_identity_namespace" {
  description = "Kubernetes namespace used by the workload identity"
  type        = string
  default     = "dev"
}

variable "workload_identity_service_account" {
  description = "Kubernetes ServiceAccount used by the workload identity"
  type        = string
  default     = "nodejs-sa"
}