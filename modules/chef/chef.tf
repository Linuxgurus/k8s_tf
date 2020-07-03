locals {
  chef_name = "chef"
  chef_labels = {
    name = "chef"
  }
}

resource "kubernetes_deployment" "chef" {
  metadata {
    name = local.chef_name
    namespace = var.namespace
    labels = local.chef_labels
  }
  spec {
    replicas = 1

    selector { match_labels = local.chef_labels }

    template {
      metadata { labels = local.chef_labels }
      spec {
        container {
          name = local.chef_name
          image = "registry:5000/chef"
          port { container_port = 443 }
          env_from {
            secret_ref {
              name = kubernetes_secret.chef.metadata.0.name
            }

          }
        }
        image_pull_secrets {
          name = module.registry_access.registry_secret
        }
      }
    }
  }
}
