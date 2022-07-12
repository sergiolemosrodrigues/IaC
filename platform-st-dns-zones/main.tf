module "dns_zones" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-dns-managed-zone"

  for_each = local.zones[terraform.workspace]

  cloud_environment = local.cloud_environment

  name       = each.key
  dns_name   = each.value.dns_name
  visibility = each.value.visibility

  private_visibility_config = {
    networks = each.value.networks
  }

  cost_center = local.cost_center
  customer    = local.customer
}
