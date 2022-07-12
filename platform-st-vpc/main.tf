module "vpc" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-network"

  name        = local.base_name
  cost_center = local.cost_center
  customer    = local.customer
}

module "subnetworks" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-subnetwork"

  for_each = { for s in local.subnetwork[terraform.workspace] : s.name => s }

  cloud_environment = local.cloud_environment

  network                  = module.vpc.self_link
  name                     = each.key
  purpose                  = lookup(each.value, "purpose", "PRIVATE")
  role                     = lookup(each.value, "role", null)
  ip_cidr_range            = each.value.ip_cidr_range
  secondary_ip_range       = lookup(each.value, "secondary_ip_range", [])
  private_ip_google_access = lookup(each.value, "private_ip_google_access", false)

  cost_center = local.cost_center
  customer    = local.customer
}
