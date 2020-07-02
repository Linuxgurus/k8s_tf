
locals {
  pg_port = 5432
  name = "postgres"
  labels = {
    name = "postgres"
  }
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name = local.name
    namespace = var.namespace
    labels = local.labels
  }
  spec {
    replicas = 1

    selector { match_labels = local.labels }

    template {
      metadata { labels = local.labels }
      spec {
        container {
          name = local.name
          image = "postgres"
          port {
            container_port = local.pg_port
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.chef.metadata.0.name
            }

          }
          volume_mount {
            name = "pgdata"
            mount_path = "/var/lib/postgresql"
          }
        }
        volume {
          name = "pgdata"
          persistent_volume_claim  {
            claim_name = local.name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres" {
  metadata {
    namespace = var.namespace
    name = local.name
  }
  spec {
    selector = local.labels
    port {
      port        = local.pg_port
      target_port = local.pg_port
    }
  }
}

resource "kubernetes_persistent_volume_claim" "database" {
  metadata {
    name = local.name
    namespace  = var.namespace
  }
  spec {
    access_modes = [ "ReadWriteOnce"]
    storage_class_name = "openebs-jiva-default"
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

