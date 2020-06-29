

# Localized EBS volumes. Worker nodes are used to store and replicate
# permament volumes
module "openebs" {
  source = "./modules/openebs"
  namespace = "openebs"
}

# A Jenkins server
module "jenkins" {
  source = "./modules/jenkins"
  namespace = "jenkins"
}


# MetalLB. This makes Load Balancers that can be seen on the local network
# Via ARP magic
module "metallb" {
  source = "./modules/metallb"
  namespace = "metallb"
  addresses = var.metal_networks
}

# Certificate manager. This signs ssl certs
module "cert_manager" {
  source = "./modules/cert_man"
  namespace = "cert-manager"
}

# An openvpn server (Not working yet)
module "openvpn" {
  source = "./modules/openvpn"
  namespace = "openvpn"
  name = "linuxguru"
  vpn_domains = [
    "vpn.linuxguru.net",
    "vpn.int.linuxguru.net"
  ]
  ca_certfile = "~/.ssl/ca.crt"
  ca_keyfile = "~/.ssl/ca.key"
  registry_auth = module.registry.auth
}

# Monitoring
module "prometheus" {
  source = "./modules/prometheus"
  namespace = "monitoring"
  name = "prometheus"
}

# A docker registry
module "registry" {
  source = "./modules/registry"
  namespace = "registry"
  vpn_domains = [
    "registry",
    "registry.linuxguru.net",
    "registry.int.linuxguru.net"
  ]
  ca_certfile = "~/.ssl/ca.crt"
  ca_keyfile = "~/.ssl/ca.key"
}
