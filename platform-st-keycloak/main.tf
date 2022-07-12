module "keycloak" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-igm"

  name               = var.base_name
  base_instance_name = var.base_name
  cloud_environment  = local.cloud_environment
  zone               = var.zone
  cost_center        = var.cost_center
  customer           = var.customer

  versions = [
    {
      name              = "default"
      instance_template = module.instance_template.id
      target_size = {
        fixed = var.target_size
      }
    }
  ]

  named_port = [
    {
      name = "ssh"
      port = 22
    },
    {
      name = "http"
      port = 80
    },
    {
      name = "http"
      port = 8080
    },
    {
      name = "https"
      port = 443
    }
  ]

  auto_healing_policies = {
    health_check      = module.health_check.id
    initial_delay_sec = 30
  }
}

module "instance_template" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-instance-template"

  name              = "keycloak"
  cloud_environment = local.cloud_environment
  machine_type      = local.instance_template.machine_type

  disk = [
    {
      source_image = data.google_compute_image.keycloak_image.id
    }
  ]

  network_interface = [
    { subnetwork = "gavb-subnetwork-private-a-shd" },
    { subnetwork = "gavb-subnetwork-private-b-shd" }
  ]

  customer    = var.customer
  cost_center = var.cost_center
}

module "health_check" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-health-check"

  name = "keycloak"

  cloud_environment = local.cloud_environment

  # check the module source for the default values
  https_health_check = [{}]

  customer    = local.customer
  cost_center = local.cost_center
}
