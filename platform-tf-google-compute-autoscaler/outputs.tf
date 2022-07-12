output "id" {
  description = "An identifier for the resource with format"
  value       = var.create_module && var.regional ? google_compute_region_autoscaler.region_autoscaler.0.id : google_compute_autoscaler.autoscaler.0.id
}

output "creation_timestamp" {
  description = "Creation timestamp in RFC3339 text format."
  value       = var.create_module && var.regional ? google_compute_region_autoscaler.region_autoscaler.0.creation_timestamp : google_compute_autoscaler.autoscaler.0.creation_timestamp
}

output "self_link" {
  description = "The URI of the created resource."
  value       = var.create_module && var.regional ? google_compute_region_autoscaler.region_autoscaler.0.self_link : google_compute_autoscaler.autoscaler.0.self_link
}
