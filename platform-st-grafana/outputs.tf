output "igm_name" {
  description = "The name of the instance group manager."
  value       = module.platform_st_grafana.igm_name
}

output "gce_name" {
  description = "The name of the virtual machines for this solution."
  value       = module.platform_st_grafana.gce_name
}

output "tp_name" {
  description = "The target pool name."
  value       = module.platform_st_grafana.tp_name
}

output "igm_target_size" {
  description = "The number of instances calculated as a fixed number or a percentage depending on the settings."
  value       = module.platform_st_grafana.igm_target_size
}

output "autohealing" {
  description = "Health check set for monitoring the instances."
  value       = module.platform_st_grafana.autohealing.name
}