data "terraform_remote_state" "cloud_environment" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket = "gavb-platform-terraform-states"
    prefix = "terraform/platform-st-cloud-environment"
  }
}