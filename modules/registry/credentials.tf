resource "random_password" "password" {
  length = 15 
  special = true
  override_special = "_%@"
}

resource "kubernetes_secret" "image-puller" {
  type = "kubernetes.io/dockerconfigjson"
  metadata {
    name = "registry-secret"
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      "auths" : {
        (var.docker_registry) : {
          email    = var.docker_email
          username = var.docker_user
          password =  random_password.password.result
          auth     = base64encode(join(":", [var.docker_user, random_password.password.result]))
        }
      }
    })
  }
}

