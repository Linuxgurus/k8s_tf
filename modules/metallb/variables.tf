variable "namespace" {
  type = string
  default = "metallb"
}

variable "release_name" {
  type = string
  default = "metallb"

}

variable "chart" {
  type = string
  default = "stable/metallb"
}


variable networks {
  type = list(string)
}
