
data "kubernetes_service" "chef" {
  metadata { 
    name = local.chef_name
    namespace = var.namespace
  }
}

output "lb" {
  value = data.kubernetes_service.chef.load_balancer_ingress.0.ip
}
