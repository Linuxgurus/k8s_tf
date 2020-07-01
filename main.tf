

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
  issuer_name = "linuxguru-ca"
  ca_certfile = "~/.ssl/ca.crt"
  ca_keyfile = "~/.ssl/ca.key"
}

# An openvpn server (Not working yet)
module "openvpn" {
  source = "./modules/openvpn"
  namespace = "openvpn"
  name = "linuxguru"
  cert_issuer = module.cert_manager.issuer
  vpn_domains = [ "vpn.linuxguru.net" ]
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
  cert_issuer = module.cert_manager.issuer
  domains = [
    "registry",
    "registry.linuxguru.net",
    "registry.int.linuxguru.net"
  ]
}

module "chef" {
  source = "./modules/chef"
  namespace = "chef"
  name = "chef"
  cert_issuer = module.cert_manager.issuer
  domains = [ "chef", "chef.int.linuxguru.net" ]
}

