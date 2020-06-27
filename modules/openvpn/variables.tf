variable namespace {
  type = string
}

variable ca_certfile {
  type = string
}

variable ca_keyfile {
  type = string
}

variable name {
  type = string
}

variable vpn_domains {
  type = list
  default = [
    "vpn.linuxguru.net",
    "vpn.int.linuxguru.net"
  ]
}

