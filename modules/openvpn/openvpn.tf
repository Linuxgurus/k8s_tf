locals {
  labels = {
    name = var.name
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}


resource "kubernetes_config_map" "config" {
  metadata {
    namespace = var.namespace
    name = var.name
  }
  data = {
    ENABLE_NAT = "true"
    DNS_SERVER = "192.168.1.1"
    LOCAL_NET = "192.168.1.0"
    LOCAL_MASK = "255.255.255.0"
    VPN_NET = "192.168.2.0"
    VPN_MASK = "255.255.255.0"
  }
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name = var.name
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
          name = var.name
          image = "jdblack/openvpn_k8s"
          security_context {
            capabilities {
              add = ["NET_ADMIN"]
            }
          }
          port {
            container_port = 1194
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.config.metadata.0.name
            }

          }
          volume_mount {
            name = "certs"
            mount_path = "/etc/openvpn/certs"
          }
        }
        volume {
          name = "certs"
          secret {
            secret_name = "server-cert"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    namespace = var.namespace
    name = var.name
  }
  spec {
    type = "LoadBalancer"
    selector = local.labels
    port {
      port        = 1194
      target_port = 1194
    }
  }
}
