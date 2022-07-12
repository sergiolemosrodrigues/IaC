output "id" {
  description = "An identifier for the resource with format"
  value       = var.create_module && var.regional ? google_compute_region_backend_service.region_backend_service.0.id : google_compute_backend_service.backend_service.0.id
}

output "creation_timestamp" {
  description = "Creation timestamp in RFC3339 text format."
  value       = var.create_module && var.regional ? google_compute_region_backend_service.region_backend_service.0.creation_timestamp : google_compute_backend_service.backend_service.0.creation_timestamp
}

output "fingerprint" {
  description = "Fingerprint of this resource. A hash of the contents stored in this object. This field is used in optimistic locking."
  value       = var.create_module && var.regional ? google_compute_region_backend_service.region_backend_service.0.fingerprint : google_compute_backend_service.backend_service.0.fingerprint
}

output "self_link" {
  description = "The URI of the created resource."
  value       = var.create_module && var.regional ? google_compute_region_backend_service.region_backend_service.0.self_link : google_compute_backend_service.backend_service.0.self_link
}
