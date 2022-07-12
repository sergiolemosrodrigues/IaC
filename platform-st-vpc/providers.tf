#--------------------------------------------------------------
#       PROVIDERS
#--------------------------------------------------------------
provider "google" {
  project = local.cloud_environment.google.project_id
  region  = local.cloud_environment.google.region
}

provider "google-beta" {
  project = local.cloud_environment.google.project_id
  region  = local.cloud_environment.google.region
}
