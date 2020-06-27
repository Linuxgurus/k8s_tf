resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "k8s_manifest" "vpn_cert" {
  namespace = var.namespace
  content = templatefile( "${path.module}/templates/ovpn_cert.tpl",{
    name = "ovpn-server",
    secretname = "ovpn-server",
    hostnames = var.vpn_domains,
    issuer = local.issuer_name
  })
}
