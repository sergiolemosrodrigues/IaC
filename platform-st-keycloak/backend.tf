#--------------------------------------------------------------
#  Terraform Backend
#--------------------------------------------------------------
terraform {
  required_version = ">=1.0.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.76.0"
    }
  }
  
  backend "gcs" {
    bucket = "gavb-platform-terraform-states"
    prefix = "terraform/platform-st-keycloak"
  }
}