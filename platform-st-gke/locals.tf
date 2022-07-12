locals {
  cloud_environment = data.terraform_remote_state.cloud_environment.outputs
  region            = "us-east1"
  base_name         = "gke"
  cost_center       = "devops"
  customer          = "gavb"
  network           = "gavb-vpc-platform-shd"
  subnetwork        = "gavb-subnetwork-private-shd"

  private_cluster_config = {
    master_ipv4_cidr_block = ""
  }

  master_authorized_networks_config = {
    authorized_source_ranges = "172.16.0.0/16"
  }

  ip_allocation_policy = [{
    cluster_secondary_range_name  = "gavb-secondary-private-pods"
    services_secondary_range_name = "gavb-secondary-private-services"
  }]
}
