
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
  source = "./modules/openvpn"
  namespace = "openvpn"
  name = "linuxguru"
  vpn_domains = [
    "vpn.linuxguru.net",
    "int.vpn.linuxguru.net"
  ]
  ca_certfile = "~/.ssl/ca.crt"
  ca_keyfile = "~/.ssl/ca.key"
}
