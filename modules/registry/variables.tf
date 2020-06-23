
variable "namespace" {
  type = string
  default = "jenkins"
}

variable "release_name" {
  default = "jenkins"

}

variable "volume_name" {
  type = string
  default = "jenkins-claim"
}

variable "chart" {
  type = string
  default = "stable/docker-registry"
}
