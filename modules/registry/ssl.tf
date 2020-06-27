module "issuer" {
  source = "../issuer"
  namespace = var.namespace
  ca_certfile = var.ca_certfile
  ca_keyfile = var.ca_keyfile
}

module "ssl_cert" {
  source = "../server_cert"
  namespace = var.namespace
  name = "server-cert"
  cert_domains = var.vpn_domains
  issuer = module.issuer.name
}

