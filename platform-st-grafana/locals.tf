locals {
  project           = "teste"
  resource_type     = "teste"
  region            = "teste"
  zone              = "teste"
  igm_name          = "teste"
  network_name      = "teste"
  subnetwork_name   = "teste"
  gce_name          = "teste"
  cost_center       = "teste"
  customer          = "teste"
  tp_name           = "teste"
  health_check_name = "teste"
  igm_target_size   = "2"
  config_file       = file("./ubuntu-generic-grafana.yml")
  named_ports       = []
  labels            = {}
}