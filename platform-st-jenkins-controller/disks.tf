resource "google_compute_disk" "jenkins_persistent_data" {
  name = "gavb-disk-jenkins-persistent-data"
  type = "pd-balanced"
  zone = local.zone
  size = 10

  labels = {
    environment = terraform.workspace
    customer    = local.customer
    cost_center = local.cost_center
    component   = local.base_name
    purpose     = "persistent-data"
  }
}

resource "google_compute_disk_resource_policy_attachment" "persistent_data_snapshot" {
  name = google_compute_resource_policy.persistent_data_snapshot.name
  disk = google_compute_disk.jenkins_persistent_data.name
  zone = local.zone
}
