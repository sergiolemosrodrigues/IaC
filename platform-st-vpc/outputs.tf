output "id" {
  description = "An identifier for the resource with format."
  value       = module.vpc.id
}

output "gateway_ipv4" {
  description = "The gateway address for default routing out of the network. This value is selected by GCP."
  value       = module.vpc.gateway_ipv4
}

output "self_link" {
  description = "The URI of the created resource."
  value       = module.vpc.self_link
}

output "subnetworks" {
  description = "Output values for the resource google_compute_subnetwork"
  value       = module.subnetworks
}
