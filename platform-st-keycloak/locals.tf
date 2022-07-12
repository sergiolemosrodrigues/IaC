locals {
  cloud_environment = data.terraform_remote_state.cloud_environment.outputs

  instance_template = {
    machine_type = "n2-standard-2"
  }

  cost_center = "devops"
  customer    = "gavb"
}