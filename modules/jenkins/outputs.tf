data "kubernetes_service" "registry" {
  metadata { 
    name = "jenkins"
    namespace = var.namespace
  }
}


output "lb" {
  value = data.kubernetes_service.registry.load_balancer_ingress.0.ip
}
