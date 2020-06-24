resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_persistent_volume_claim" "data" {
  metadata {
    name = var.volume_name
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

resource "kubernetes_persistent_volume_claim" "config" {
  metadata {
    name = var.volume_name
    namespace  = var.namespace
  }
  spec {
    access_modes = [ "ReadWriteOnce"]
    storage_class_name = "openebs-jiva-default"
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = "gitlab"
    namespace = "${kubernetes_namespace.namespace.metadata.0.name}"
    labels {
      app = "gitlab"
    }
  }

  spec {
    replicas = "1"
    selector {
      app = "gitlab"
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels {
          app  = "gitlab"
          name = "gitlab"
        }
      }

      spec {
        container {
          image = "gitlab/gitlab-ce"
          name  = "gitlab"


          resources {
            limits {
              cpu    = "2"
              memory = "2G"
            }
          }

          port {
            name           = "http"
            container_port = 3000
            protocol       = "TCP"
          }

          env = [
            {
              name = "GF_SECURITY_ADMIN_PASSWORD"

              value_from {
                secret_key_ref {
                  key  = "grafana-root-password"
                  name = "${kubernetes_secret.grafana-secret.metadata.0.name}"
                }
              }
            },
            {
              name  = "GF_INSTALL_PLUGINS"
              value = "grafana-clock-panel,grafana-simple-json-datasource,grafana-piechart-panel"
            },
            {
              name  = "GF_PATH_PROVISIONING"
              value = "/etc/grafana/provisioning"
            },
          ]

          volume_mount {
            mount_path = "/var/lib/grafana"
            name       = "grafana-volume"
          }

          volume_mount {
            mount_path = "/etc/grafana/provisioning/datasources/"
            name       = "grafana-config-datasources"
          }

          volume_mount {
            mount_path = "/etc/grafana/provisioning/dashboards/"
            name       = "grafana-config-dashboards"
          }

          volume_mount {
            mount_path = "/etc/grafana/dashboards"
            name       = "grafana-dashboards"
          }
        }

        volume {
          name = "data"
          persistent_volume_claim {
            claim_name = "${kubernetes_persistent_volume_claim.data.metadata.0.name}"
          }
        }

        volume {
          name = "config"
          persistent_volume_claim {
            claim_name = "${kubernetes_persistent_volume_claim.config.metadata.0.name}"
          }
        }

      }
    }
  }
}

