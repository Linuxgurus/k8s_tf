resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}


resource "helm_release" "release" {
  name  = var.release_name
  chart = "stable/openebs"
  namespace = var.namespace
}

