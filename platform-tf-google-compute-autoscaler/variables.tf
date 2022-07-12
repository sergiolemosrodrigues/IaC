variable "name" {
  type        = string
  description = " The account id that is used to generate the service account email address and a stable unique id. It is unique within a project, must be 6-30 characters long, and match the followin rules: the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash. Changing this forces a new service account to be created."
}

variable "cloud_environment" {
  description = "An environment data with all information needed to manage this resource."
}

variable "target" {
  description = "URL of the managed instance group that this autoscaler will scale."
  type = string
}

variable "description" {
  type        = string
  description = "A text description of the service account. Must be less than or equal to 256 UTF-8 bytes."
  default     = null
}

variable "autoscaling_policy" {
  description = "value"
  type = any
}

variable "zone" {
  description = "URL of the zone where the instance group resides."
  type        = string
  default     = null
}

variable "region" {
  description = "URL of the region where the instance group resides."
  type        = string
  default     = null
}

variable "project" {
  type        = string
  description = "The ID of the project that the service account will be created in. Defaults to the provider project configuration."
  default     = null
}

variable "customer" {
  type        = string
  description = "Customer owner of this resource"
}

variable "cost_center" {
  description = "Used to group resource costs."
  type        = string
}

variable "create_module" {
  type        = bool
  description = "Allow to conditionally  control when this module should be created."
  default     = true
}

variable "regional" {
  description = "Choose if the resource is regional or global"
  type        = bool
  default     = true
}