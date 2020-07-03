resource "kubernetes_secret" "image-puller" {
  type = "kubernetes.io/dockerconfigjson"
  metadata {
    namespace = var.namespace
    name = var.secret_name
  }
  data = { ".dockerconfigjson" = var.registry_auth }
}
