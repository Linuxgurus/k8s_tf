
module "jenkins" {
  source = "./modules/jenkins"
  namespace = "jenkins"
}

module "registry" {
  source = "./modules/registry"
  namespace = "registry"
}
