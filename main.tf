
module "jenkins" {
  source = "./modules/jenkins"
  namespace = "jenkins"
}

module "registry" {
  source = "./modules/registry"
  namespace = "registry"
}

module "metallb" {
  source = "./modules/metallb"
  namespace = "metallb"
  addresses = var.metal_networks
}

