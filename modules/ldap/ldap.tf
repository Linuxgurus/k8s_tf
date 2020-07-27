locals {
  res_name = "${var.release_name}-openldap"
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

# check out https://github.com/osixia/docker-openldap/issues/105#issuecomment-279673189 

resource "helm_release" "release" {
  name  = var.release_name
  chart = "stable/openldap"
  namespace = var.namespace

  set {
    name = "persistence.storageClass"
    value = "openebs-jiva-default"
  }

  set {
    name = "service.type"
    value = "LoadBalancer"
  }

  set {
    name = "tls.enabled"
    value = true
  }

  set {
    name = "tls.secret"
    value = module.ssl_cert.secret
  }

  set {
    name = "env.LDAP_TLS_VERIFY_CLIENT"
    value = "try"
    }
  }

}

