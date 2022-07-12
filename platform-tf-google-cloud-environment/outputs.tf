output "region" {
  value = local.region[terraform.workspace]
}

output "project_id" {
  value = local.project_id[terraform.workspace]
}

output "environment" {
  value = local.environment[terraform.workspace]
}