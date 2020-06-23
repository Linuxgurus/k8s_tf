
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
