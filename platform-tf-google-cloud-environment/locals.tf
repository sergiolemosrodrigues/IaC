locals {
  region = {
    shd = "us-east1"
    dev = "us-east1"
    uat = "us-east1"
    prd = "us-east1"
  }

  project_id = {
    shd = "platform-resources"
    dev = "products-resources-dev"
    uat = "products-resources-uat"
    prd = "products-resources-prd"
  }

  environment = {
    shd = {
      lower = lower(terraform.workspace)
      upper = upper(terraform.workspace)
    }
    dev = {
      lower = lower(terraform.workspace)
      upper = upper(terraform.workspace)
    }
    uat = {
      lower = lower(terraform.workspace)
      upper = upper(terraform.workspace)
    }
    prd = {
      lower = lower(terraform.workspace)
      upper = upper(terraform.workspace)
    }
  }
}
