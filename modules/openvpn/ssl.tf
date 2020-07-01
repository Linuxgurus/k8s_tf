module "ssl_cert" {
  source = "../server_cert"
  namespace = var.namespace
  name = "server-cert"
  cert_domains = var.vpn_domains
  issuer = var.cert_issuer
}

