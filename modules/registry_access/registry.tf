resource "kubernetes_secret" "image-puller" {
  type = "kubernetes.io/dockerconfigjson"
  metadata {
    namespace = var.namespace
    name = "registry-secret"
  }
  data = { ".dockerconfigjson" = var.registry_auth }
}
