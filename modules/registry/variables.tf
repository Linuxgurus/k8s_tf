
variable "namespace" {
  type = string
  default = "registry"
}

variable "release_name" {
  default = "registry"

}

variable "volume_name" {
  type = string
  default = "registry-claim"
}

variable "chart" {
  type = string
  default = "stable/docker-registry"
}

variable "docker_user" {
  type = string
  default = "docker"
}

variable "docker_email" {
  type = string
  default = "docker@linuxguru.net"
}

variable "docker_registry" {
  type = string
  default = "registry:5000"
}


variable ca_certfile {
  type = string
}

variable ca_keyfile {
  type = string
}

variable vpn_domains {
  type = list
}

