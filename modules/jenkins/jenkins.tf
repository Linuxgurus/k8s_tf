resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "random_password" "password" {
  length = 15
  special = true
  override_special = "_%@"
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

  set {
    name = "master.runAsUser"
    value = 0
  }

  set {
    name = "master.adminPassword"
    value = random_password.password.result
  }

  set {
    name = "master.fsGroup"
    value = 0
  }

}

