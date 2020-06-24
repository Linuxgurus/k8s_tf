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
address-pools:
- name: default
  protocol: layer2
  addresses:
  - ${var.addresses}
EOT
}
