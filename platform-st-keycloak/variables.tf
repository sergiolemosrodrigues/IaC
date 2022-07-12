variable "base_name" {
  type    = string
  default = "keycloak"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}

variable "cost_center" {
  type    = string
  default = "devops"
}

variable "customer" {
  type    = string
  default = "gavb"
}

variable "source_image_family" {
  type    = string
  default = "gavb-image-keycloak-family"
}

variable "target_size" {
  type    = number
  default = 1
}
