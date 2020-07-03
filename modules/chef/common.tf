resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

module "registry_access"  {
  source =  "../registry_access"
  namespace = var.namespace
  registry_auth = var.registry_auth
}

