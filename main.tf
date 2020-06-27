
module "openebs" {
  source = "./modules/openebs"
  namespace = "openebs"
}

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

module "cert_manager" {
  source = "./modules/cert_man"
  namespace = "cert-manager"
}

module "openvpn" {
  namespace = "openvpn"
  name = "linuxguru"
  source = "./modules/openvpn"
  ca_certfile = "~/.ssl/ca.crt"
  ca_keyfile = "~/.ssl/ca.key"
}
