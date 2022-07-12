module "gke" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-gke"

  cloud_environment                 = local.cloud_environment
  name                              = local.base_name
  cost_center                       = local.cost_center
  customer                          = local.customer
  network                           = local.network
  subnetwork                        = local.subnetwork
  region                            = local.region
  private_cluster_config            = local.private_cluster_config
  master_authorized_networks_config = local.master_authorized_networks_config
  ip_allocation_policy              = local.ip_allocation_policy
}
