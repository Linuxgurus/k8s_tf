data "kubernetes_service" "grafana" {
  metadata { 
    name = "prometheus-grafana"
    namespace = var.namespace
  }
}

data "kubernetes_secret" "grafana" {
  metadata { 
    name = "prometheus-grafana"
    namespace = var.namespace
  }
}

output "grafana-lb" {
  value = data.kubernetes_service.grafana.load_balancer_ingress.0.ip
}

output "grafana-admin" {
  value = data.kubernetes_secret.grafana.data["admin-user"]
}

output "grafana-pass" {
  value = data.kubernetes_secret.grafana.data["admin-password"]
}
