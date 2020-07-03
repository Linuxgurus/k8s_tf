resource "kubernetes_role" "knife" {
  metadata {
    namespace = var.namespace
    name = var.name
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["chef"]
    verbs          = ["create", "update", "patch"]
  }
}
