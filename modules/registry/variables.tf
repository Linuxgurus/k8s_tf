
variable "namespace" { }
variable domains     {}
variable cert_issuer {}

variable "release_name" { default = "registry" }

variable "volume_name" { default = "registry-claim" }

variable "chart" { default = "stable/docker-registry" }

variable "docker_user" { default = "docker" }

variable "docker_email" { default = "docker@linuxguru.net" }

variable "docker_registry" { default = "registry:5000" }

