# Please see https://metallb.universe.tf/installation/ about IPVS

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "release" {
  name  = var.release_name
  chart = var.chart
  namespace = var.namespace
  set {
    name = "arpAddresses"
    value = "192.168.1.50-192.168.1.99"
  }
  depends_on = [ kubernetes_config_map.metallb ]
}


