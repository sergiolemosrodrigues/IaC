variable "customer" {
  type        = string
  description = "Owner of the image"
  default     = "gavb"
}

variable "environment" {
  type        = string
  description = "Environment used while building this image (ex: prd). You can use environment variable to define its value."
  default     = "shd"
}

variable "project_id" {
  type        = string
  description = "The project ID that will be used to launch instances and store images."
  default     = "platform-resources"
}

variable "source_image_family" {
  type        = string
  description = "The source image family to use to create the new image from. The image family always returns its latest image that is not deprecated."
  default     = "ubuntu-2004-lts"
}

variable "zone" {
  type        = string
  description = "The zone in which to launch the instance used to create the image. Example: 'us-central1-a'"
  default     = "us-east1-b"
}

variable "image_name" {
  type        = string
  description = "The unique name of the resulting image. "
  default     = "base"
}

variable "image_family" {
  type        = string
  description = "The name of the image family to which the resulting image belongs."
  default     = "gavb-image-base-family"
}

variable "machine_type" {
  type        = string
  description = "The machine type."
  default     = "e2-standard-2"
}

variable "subnetwork" {
  type        = string
  description = " The Google Compute subnetwork id or URL to use for the launched instance. Only required if the network has been created with custom subnetting"
  default     = "gavb-subnetwork-private-shd"
}

variable "use_internal_ip" {
  description = " If true, use the instance's internal IP instead of its external IP during building."
  type        = bool
  default     = true
}

variable "ssh_username" {
  type        = string
  default     = "ubuntu"
  description = "The username to connect to SSH with."
}
