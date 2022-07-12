#--------------------------------------------------------------
#       PROVIDERS
#--------------------------------------------------------------
provider "google" {
  project = module.google_cloud_environment.project
  region  = module.google_cloud_environment.region
}
