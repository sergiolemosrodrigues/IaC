module "jenkins" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-instance"

  cloud_environment        = local.cloud_environment
  name                     = local.base_name
  source_instance_template = module.instance_template.id
  zone                     = local.zone
  resource_policies        = [google_compute_resource_policy.business_hour_schedule.id]

  customer    = local.customer
  cost_center = local.cost_center
}

module "instance_template" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-instance-template"

  name_prefix       = local.base_name
  cloud_environment = local.cloud_environment
  machine_type      = local.instance_template.machine_type
  tags              = ["allow-health-checks"]

  disk = [
    {
      source_image = data.google_compute_image.jenkins_image.id
    }
  ]

  network_interface = [
    {
      network    = "projects/platform-resources/global/networks/gavb-vpc-platform-shd"
      subnetwork = "projects/platform-resources/regions/us-east1/subnetworks/gavb-subnetwork-private-shd"
    }
  ]

  customer    = local.customer
  cost_center = local.cost_center
}
