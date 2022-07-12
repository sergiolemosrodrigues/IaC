module "record_set" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-dns-record-set"

  cloud_environment = local.cloud_environment

  name         = "${local.base_name}.gavb.in."
  type         = "A"
  managed_zone = "gavb-in"
  rrdatas      = [module.jenkins.network_ip]

  customer    = local.customer
  cost_center = local.cost_center
}