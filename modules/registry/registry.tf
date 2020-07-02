resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}


resource "helm_release" "release" {
  name  = var.release_name
  chart = var.chart
  namespace = var.namespace

  set {
    name = "updateStrategy.type"
    value = "Recreate"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name = "persistence.enabled"
    value = true
  }

  set {
    name = "tlsSecretName"
    value = module.ssl_cert.secret
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
    value = "docker:${bcrypt(random_password.password.result)}"
  }

}

