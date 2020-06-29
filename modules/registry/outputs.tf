
data "kubernetes_service" "registry" {
  metadata { 
    name = join("-", [ var.release_name, "docker-registry" ])
    namespace = var.namespace
  }
  depends_on = [ helm_release.release ]
}

output "lb" {
  value = data.kubernetes_service.registry.load_balancer_ingress.0.ip
}

output "password" {
  value = random_password.password.result
}

output "auth" {
  value = local.docker_config_json
}

