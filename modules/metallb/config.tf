resource "kubernetes_config_map" "metallb" {
  metadata {
    name = "metallb-config"
    namespace = var.namespace
  }

  data = {
    config = data.template_file.config.rendered
  }
}

data "template_file" "config" {
  template = <<EOT
  apiVersion: v1
  kind: ConfigMap
  metadata:
  namespace: metallb
  name: metallb-config
  data:
  config: |
  address-pools:
  - name: default
  protocol: layer2
  addresses:
  - ${var.addresses}
  EOT
}

