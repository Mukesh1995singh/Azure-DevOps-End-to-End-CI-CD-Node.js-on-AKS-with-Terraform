output "release_name" {
  description = "NGINX Ingress Helm release name"
  value       = helm_release.nginx_ingress.name
}

output "namespace" {
  description = "NGINX Ingress namespace"
  value       = helm_release.nginx_ingress.namespace
}

output "status" {
  description = "NGINX Ingress Helm release status"
  value       = helm_release.nginx_ingress.status
}