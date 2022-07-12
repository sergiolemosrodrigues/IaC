data "google_compute_image" "jenkins_image" {
  family  = local.source_image_family
}