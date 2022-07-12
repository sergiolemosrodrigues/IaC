data "google_compute_image" "keycloak_image" {
  family  = var.source_image_family
}