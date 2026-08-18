resource "helm_release" "nginx_ingress" {
  name             = var.release_name
  repository       = var.repository
  chart            = var.chart
  namespace        = var.namespace
  create_namespace = true
  version          = var.chart_version

  set = [
    {
      name  = "controller.service.type"
      value = "LoadBalancer"
    },
    {
      name  = "controller.replicaCount"
      value = var.replica_count
    }
  ]
}