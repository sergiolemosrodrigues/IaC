locals {
  cloud_environment = data.terraform_remote_state.cloud_environment.outputs

  base_name           = "jenkins"
  zone                = "us-east1-b"
  source_image_family = "gavb-image-jenkins-family"
  target_size         = 0

  instance_template = {
    machine_type = "e2-standard-2"
  }

  cost_center = "devops"
  customer    = "gavb"
}
