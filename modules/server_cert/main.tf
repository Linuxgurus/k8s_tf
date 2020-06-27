resource "k8s_manifest" "cert" {
  namespace = var.namespace
  content = templatefile( "${path.module}/templates/server_cert.tpl",{
    name = var.name,
    secretname = var.name,
    hostnames = var.cert_domains,
    issuer = var.issuer
  })
}

