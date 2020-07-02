resource "random_password" "db_pass" {
    length = 16
}

resource "kubernetes_secret" "chef"  {
  metadata {
    name = "chef"
    namespace = var.namespace
  }
  data = {
    POSTGRES_USER = "chef"
    POSTGRES_PASSWORD = random_password.db_pass.result
  }
}

