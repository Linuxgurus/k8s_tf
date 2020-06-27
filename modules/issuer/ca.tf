locals {
  issuer_name = var.name
  ca_name = join("-",[var.name,"ca"])
  issuer = <<EOT

apiVersion: cert-manager.io/v1alpha2
kind: Issuer
metadata:
  name: ${local.issuer_name}
spec:
  ca:
    secretName: ${local.ca_name}
EOT
}

resource "kubernetes_secret" "ca-key"  {
  type="kubernetes.io/tls"
  metadata {
    namespace = var.namespace
    name = local.ca_name
  }
  data = {
    "tls.crt" = file(var.ca_certfile)
    "tls.key" = file(var.ca_keyfile)
  }
}

resource "k8s_manifest" "issuer" {
  namespace = var.namespace
  content = local.issuer
}
