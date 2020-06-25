
data "kubernetes_service" "registry" {
  metadata { 
    name = join("-", [ var.release_name, "docker-registry" ])
    namespace = var.namespace
  }
}

output "lb" {
  value = data.kubernetes_service.registry.load_balancer_ingress.0.ip
}

output "password" {
  value = random_password.password.result
}

