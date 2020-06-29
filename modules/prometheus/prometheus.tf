resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "release" {
  name  = var.release_name
  chart = var.chart
  namespace = var.namespace
  set {
    name = "grafana.service.type"
    value = "LoadBalancer"
  }
}

