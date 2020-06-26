data "kubernetes_service" "jenkins" {
  metadata { 
    name = var.release_name
    namespace = var.namespace
  }
  depends_on = [ helm_release.release ]
}

data "kubernetes_secret" "secret" {
  metadata { 
    name = var.release_name
    namespace = var.namespace
  }
}

output "password" {
  value = data.kubernetes_secret.secret.data["jenkins-admin-password"]
}

output "lb" {
  value = data.kubernetes_service.jenkins.load_balancer_ingress.0.ip
}

