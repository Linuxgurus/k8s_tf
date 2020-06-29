resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}


resource "kubernetes_config_map" "config" {
  metadata {
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
  }
  spec {
    replicas = 1
    template {
      metadata {
        labels = {
          app = var.name
        }
      }
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
            name = var.name
            container_port = 1194
            protocol = "TCP"
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
    namespace = var.name
    name = var.name
  }
  spec {
    selector = {
      app = var.name
    }
    port {
      port        = 1194
      target_port = 443
    }
    type = "LoadBalancer"
  }
}
