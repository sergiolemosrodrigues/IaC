locals {
  cloud_environment = data.terraform_remote_state.cloud_environment.outputs

  base_name   = "platform"
  cost_center = "devops"
  customer    = "gavb"
  subnetwork = {
    shd = [
      {
        name                     = "private"
        ip_cidr_range            = "172.16.0.0/20"
        private_ip_google_access = true
        secondary_ip_range = [
          {
            range_name    = "${local.customer}-secondary-private-services"
            ip_cidr_range = "10.26.0.0/23"
          },
          {
            range_name    = "${local.customer}-secondary-private-pods"
            ip_cidr_range = "10.36.0.0/20"
          }
        ]
      },
      {
        name          = "public"
        ip_cidr_range = "172.16.16.0/20"
      },
      {
        name                     = "resource"
        ip_cidr_range            = "172.16.32.0/20"
        private_ip_google_access = true
      },
      {
        name                     = "internal-loadbalancer"
        ip_cidr_range            = "172.16.48.0/22"
        purpose                  = "INTERNAL_HTTPS_LOAD_BALANCER"
        role                     = "ACTIVE"
      }
    ],
    dev = [
      {
        name                     = "private"
        ip_cidr_range            = "172.26.0.0/20"
        private_ip_google_access = true
        secondary_ip_range = [
          {
            range_name    = "${local.customer}-secondary-private-services"
            ip_cidr_range = "10.46.0.0/23"
          },
          {
            range_name    = "${local.customer}-secondary-private-pods"
            ip_cidr_range = "10.56.0.0/20"
          }
        ]
      },
      {
        name          = "public"
        ip_cidr_range = "172.26.16.0/20"
      },
      {
        name                     = "resource"
        ip_cidr_range            = "172.26.32.0/20"
        private_ip_google_access = true
      },
      {
        name                     = "internal-loadbalancer"
        ip_cidr_range            = "172.26.48.0/22"
        purpose                  = "INTERNAL_HTTPS_LOAD_BALANCER"
        role                     = "ACTIVE"
      }
    ]
    uat = [
      {
        name                     = "private"
        ip_cidr_range            = "172.36.0.0/20"
        private_ip_google_access = true
        secondary_ip_range = [
          {
            range_name    = "private-a-secondary-services"
            ip_cidr_range = "10.66.0.0/23"
          },
          {
            range_name    = "private-a-secondary-pods"
            ip_cidr_range = "10.76.0.0/20"
          }
        ]
      },
      {
        name          = "public"
        ip_cidr_range = "172.36.16.0/20"
      },
      {
        name                     = "resource"
        ip_cidr_range            = "172.36.32.0/20"
        private_ip_google_access = true
      },
      {
        name                     = "internal-loadbalancer"
        ip_cidr_range            = "172.36.48.0/20"
        purpose                  = "INTERNAL_HTTPS_LOAD_BALANCER"
        role                     = "ACTIVE"
      }
    ]
    prd = [
      {
        name                     = "private"
        ip_cidr_range            = "172.46.0.0/20"
        private_ip_google_access = true
        secondary_ip_range = [
          {
            range_name    = "${local.customer}-secondary-private-services"
            ip_cidr_range = "10.86.0.0/23"
          },
          {
            range_name    = "${local.customer}-secondary-private-pods"
            ip_cidr_range = "10.96.0.0/20"
          }
        ]
      },
      {
        name          = "public"
        ip_cidr_range = "172.46.16.0/20"
      },
      {
        name                     = "resource"
        ip_cidr_range            = "172.46.32.0/20"
        private_ip_google_access = true
      },
      {
        name                     = "internal-loadbalancer"
        ip_cidr_range            = "172.46.48.0/20"
        purpose                  = "INTERNAL_HTTPS_LOAD_BALANCER"
        role                     = "ACTIVE"
      }
    ]
  }
}
