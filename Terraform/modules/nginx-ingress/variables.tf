variable "release_name" {
  description = "NGINX Ingress Helm release name"
  type        = string
  default     = "nginx-ingress"
}

variable "repository" {
  description = "NGINX Ingress Helm repository"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "chart" {
  description = "NGINX Ingress Helm chart"
  type        = string
  default     = "ingress-nginx"
}

variable "chart_version" {
  description = "NGINX Ingress Helm chart version"
  type        = string
}

variable "namespace" {
  description = "NGINX Ingress namespace"
  type        = string
  default     = "ingress-nginx"
}

variable "replica_count" {
  description = "Number of NGINX Ingress controller replicas"
  type        = number
  default     = 2
}