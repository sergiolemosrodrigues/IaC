locals {
  cloud_environment = data.terraform_remote_state.cloud_environment.outputs
  
  customer    = "gavb"
  cost_center = "devops"

  zones = {
    shd = {
      gavb-in = {
        dns_name   = "gavb.in."
        visibility = "private"
        networks   = ["projects/platform-resources/global/networks/gavb-vpc-platform-shd"]
      }
    },
    dev = {
      dev-gavb-in = {
        dns_name   = "dev-gavb.in."
        visibility = "private"
        networks   = ["projects/products-resources-dev/global/networks/gavb-vpc-products-dev"]
      }
    },
    uat = {
      uat-gavb-in = {
        dns_name   = "uat-gavb.in."
        visibility = "private"
        networks   = ["projects/products-resources-uat/global/networks/gavb-vpc-products-uat"]
      }
    },
    prd = {
      prd-gavb-in = {
        dns_name   = "prd-gavb.in."
        visibility = "private"
        networks   = ["projects/products-resources-prd/global/networks/gavb-vpc-products-prd"]
      }
    }
  }
}
