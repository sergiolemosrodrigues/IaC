module "platform_st_grafana" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-igm"

  project           = local.project
  resource_type     = local.resource_type
  region            = local.region
  zone              = local.zone
  igm_name          = local.igm_name
  network_name      = local.network_name
  subnetwork_name   = local.subnetwork_name
  gce_name          = local.gce_name
  cost_center       = local.cost_center
  customer          = local.customer
  tp_name           = local.tp_name
  health_check_name = local.health_check_name
  igm_target_size   = local.igm_target_size
  config_file       = local.config_file
  named_ports       = local.named_ports
  labels            = local.labels
}