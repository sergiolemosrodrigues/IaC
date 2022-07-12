module "jenkins" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-igm"

  regional           = true
  name               = local.base_name
  base_instance_name = local.base_name
  cloud_environment  = local.cloud_environment
  cost_center        = local.cost_center
  customer           = local.customer

  versions = [
    {
      name              = "default"
      instance_template = module.instance_template.id
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
      name = "https"
      port = 443
    },
    {
      name = "jenkins"
      port = 3000
    }
  ]

  # TODO: This health check need to be global. We need to understand how health checks
  # correlates between instance group manager, backend services AND load balancer
  #   auto_healing_policies = {
  #     health_check      = module.health_check.id
  #     initial_delay_sec = 60
  #   }
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

module "backend_health_check" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-health-check"

  name              = local.base_name
  cloud_environment = local.cloud_environment

  http_health_check = [
    {
      path               = "/"
      port_specification = "USE_NAMED_PORT"
      port_name          = "jenkins"
    }
  ]

  customer    = local.customer
  cost_center = local.cost_center
}

module "backend_service" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-backend-service"

  cloud_environment = local.cloud_environment

  name             = local.base_name
  session_affinity = "NONE"
  protocol         = "HTTP"
  port_name        = "jenkins"
  health_checks    = [module.backend_health_check.id]

  backend = [
    {
      group           = module.jenkins.instance_group
      balancing_mode  = "UTILIZATION"
      capacity_scaler = 1.0
    }
  ]

  customer    = local.customer
  cost_center = local.cost_center
}

module "url_map" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-url-map"

  cloud_environment = local.cloud_environment

  name            = local.base_name
  default_service = module.backend_service.id

  customer    = local.customer
  cost_center = local.cost_center
}

module "http_proxy" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-target-proxy"

  cloud_environment = local.cloud_environment

  name        = local.base_name
  target_type = "HTTP_REGION"

  url_map = module.url_map.id

  customer    = local.customer
  cost_center = local.cost_center
}

module "load_balancer" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-compute-forwarding-rule"

  name = local.base_name

  cloud_environment = local.cloud_environment

  target     = module.http_proxy.id
  port_range = "80"

  network    = "projects/platform-resources/global/networks/gavb-vpc-platform-shd"
  subnetwork = "projects/platform-resources/regions/us-east1/subnetworks/gavb-subnetwork-private-shd"

  customer    = local.customer
  cost_center = local.cost_center
}

module "record_set" {
  source = "git@ssh.dev.azure.com:v3/gavb-consulting/EngenhariaDePlataforma/platform-tf-google-dns-record-set"

  cloud_environment = local.cloud_environment

  name         = "${local.base_name}.gavb.in."
  type         = "A"
  managed_zone = "gavb-in"
  rrdatas      = [module.load_balancer.ip_address]

  customer    = local.customer
  cost_center = local.cost_center
}
