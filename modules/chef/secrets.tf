resource "kubernetes_role" "knife" {
  metadata {
    name = "chef-knife"
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["chef_knife"]
    verbs          = ["create", "update", "patch"]
  }
}

