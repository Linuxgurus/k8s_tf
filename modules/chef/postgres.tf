locals {
  pg_port = 5432
  db_name = "postgres"
  db_labels = {
    name = "postgres"
  }
}

resource "kubernetes_deployment" "postgres" {
  metadata {
    name = local.db_name
    namespace = var.namespace
    labels = local.db_labels
  }
  spec {
    replicas = 1

    selector { match_labels = local.db_labels }

    template {
      metadata { labels = local.db_labels }
      spec {
        container {
          name = local.db_name
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
            claim_name = local.db_name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "postgres" {
  metadata {
    namespace = var.namespace
    name = local.db_name
  }
  spec {
    selector = local.db_labels
    port {
      port        = local.pg_port
      target_port = local.pg_port
    }
  }
}

resource "kubernetes_persistent_volume_claim" "database" {
  metadata {
    name = local.db_name
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

