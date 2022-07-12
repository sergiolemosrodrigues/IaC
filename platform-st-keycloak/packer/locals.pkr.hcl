locals {
  image_name = "${lower(var.customer)}-image-${var.image_name}-${lower(var.environment)}-${formatdate("YYMMDD-hhmmss", timestamp())}"

  labels = {
    provisioner = "hashicorp-packer"
    environment = "shd"
    customer    = var.customer
    cost_center = "devops"
  }

  image_labels = {
    name        = local.image_name
    provisioner = "hashicorp-packer"
    environment = var.environment
    customer    = var.customer
    no_delete   = "true"
    cost_center = "devops"
  }
}
