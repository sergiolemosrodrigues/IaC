# https://www.packer.io/docs/builders/googlecompute
source "googlecompute" "linux" {
  project_id          = var.project_id
  source_image_family = var.source_image_family
  machine_type        = var.machine_type
  zone                = var.zone

  subnetwork      = var.subnetwork
  use_internal_ip = var.use_internal_ip
  ssh_username    = var.ssh_username

  image_name   = local.image_name
  image_family = var.image_family

  # used for the packer launched instance
  labels = local.labels
  # used for the packer generated image
  image_labels = local.image_labels
}
