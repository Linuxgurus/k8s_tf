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
  chart = var.chart
  namespace = var.namespace

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name = "persistence.enabled"
    value = true
  }

  set {
    name = "persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.volume.metadata.0.name
  }
  
  set {
    name = "persistence.storageClass"
    value = "openebs-jiva-default"
  }

  set {
    name = "persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.volume.metadata.0.name
  }
  

  set {
    name = "persistence.accessMode"
    value = "ReadWriteOnce"
  }

  set {
    name = "secrets.htpasswd"
    value = "docker:$2y$05$cChOfj1KYwQNVRojQRlawOmZKv7wqfrrE9keM2auvezqX7Hnvv/o6"
  }

}

