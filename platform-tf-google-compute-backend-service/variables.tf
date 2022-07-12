variable "name" {
  description = "Name of the resource. I must be 1-63 characters long, and match the following rules: the first character must be a lowercase letter, and all following characters must be a dash, lowercase letter, or digit, except the last character, which cannot be a dash."
  type        = string
}

variable "regional" {
  description = "Choose if the resource is regional or global"
  type        = bool
  default     = true
}

variable "cloud_environment" {
  description = "An environment data with all information needed to manage this resource."
}

variable "affinity_cookie_ttl_sec" {
  description = "Lifetime of cookies in seconds if session_affinity is GENERATED_COOKIE. If set to 0, the cookie is non-persistent and lasts only until the end of the browser session (or equivalent). The maximum allowed value for TTL is one day. When the load balancing scheme is INTERNAL, this field is not used."
  type        = number
  default     = 0
}

variable "backend" {
  description = "The set of backends that serve this backend service."
  type        = any
  default     = []
}

variable "circuit_breakers" {
  description = "Settings controlling the volume of connections to a backend service. This field is applicable only when the load_balancing_scheme is set to INTERNAL_MANAGED and the protocol is set to HTTP, HTTPS, or HTTP2."
  type        = any
  default     = {}
}

variable "consistent_hash" {
  description = "Consistent Hash-based load balancing can be used to provide soft session affinity based on HTTP headers, cookies or other properties. This load balancing policy is applicable only for HTTP connections."
  type        = any
  default     = {}
}

variable "cdn_policy" {
  description = "Cloud CDN configuration for this BackendService."
  type        = any
  default     = {}
}

variable "connection_draining_timeout_sec" {
  description = "ime for which instance will be drained (not accept new connections, but still work to finish started)."
  type        = number
  default     = null
}

variable "description" {
  description = " An optional description of this resource. Provide this property when you create the resource."
  type        = string
  default     = null
}

variable "failover_policy" {
  description = "Policy for failovers."
  type        = any
  default     = {}
}

variable "enable_cdn" {
  description = "If true, enable Cloud CDN for this RegionBackendService."
  type        = bool
  default     = false
}

variable "health_checks" {
  description = "The set of URLs to HealthCheck resources for health checking this RegionBackendService. Currently at most one health check can be specified"
  type        = list(string)
}

variable "load_balancing_scheme" {
  description = " Indicates what kind of load balancing this regional backend service will be used for. A backend service created for one type of load balancing cannot be used with the other(s)."
  type        = string
  default     = "INTERNAL_MANAGED"
}

variable "locality_lb_policy" {
  description = "The load balancing algorithm used within the scope of the locality."
  type        = string
  default     = "ROUND_ROBIN"
}

variable "outlier_detection" {
  description = ""
  type        = any
  default     = {}
}

variable "port_name" {
  description = " A named port on a backend instance group representing the port for communication to the backend VMs in that group."
  type        = string
  default     = null
}

variable "protocol" {
  description = "The protocol this RegionBackendService uses to communicate with backends."
  type        = string
  default     = "HTTPS"
}

variable "session_affinity" {
  description = "Type of session affinity to use. Session affinity is not applicable if the protocol is UDP."
  type        = string
  default     = "GENERATED_COOKIE"
}

variable "timeout_sec" {
  description = "How many seconds to wait for the backend before considering it a failed request."
  type        = number
  default     = 30
}

variable "log_config" {
  description = "This field denotes the logging options for the load balancer traffic served by this backend service. If logging is enabled, logs will be exported to Stackdriver."
  type        = any
  default     = {}
}

variable "project" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "network" {
  description = "The URL of the network to which this backend service belongs. This field can only be specified when the load balancing scheme is set to INTERNAL."
  type        = string
  default     = null
}

variable "region" {
  description = "Where the target pool resides. Defaults to project region."
  type        = string
  default     = null
}

variable "cost_center" {
  description = "Used to group resource costs."
  type        = string
}

variable "customer" {
  description = "Customer owner of this resource."
  type        = string
}

variable "create_module" {
  type        = bool
  description = "Allow to conditionally create this module"
  default     = true
}
