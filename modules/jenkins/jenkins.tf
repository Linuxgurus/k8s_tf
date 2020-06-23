resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_persistent_volume_claim" "volume" {
  metadata {
    name = var.volume_name
    namespace  = var.namespace
  }
  spec {
    access_modes = [ "ReadWriteOnce"]
    storage_class_name = "openebs-jiva-default"
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

resource "helm_release" "release" {
  name  = var.release_name
  chart = "stable/jenkins"
  namespace = var.namespace

  set {
    name  = "master.serviceType"
    value = "LoadBalancer"
  }

  set {
    name = "persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.volume.metadata.0.name
  }

  set {
    name = "persistence.accessMode"
    value = "ReadWriteOnce"
  }
}

