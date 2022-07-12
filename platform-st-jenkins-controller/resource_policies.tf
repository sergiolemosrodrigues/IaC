resource "google_compute_resource_policy" "business_hour_schedule" {
  name        = "gavb-policy-jenkins-business-hour-schedule"
  description = "Start and stop instances"

  instance_schedule_policy {
    vm_start_schedule {
      schedule = "0 8 * * 1-5"
    }
    vm_stop_schedule {
      schedule = "0 19 * * 1-5"
    }
    time_zone = "America/Sao_Paulo"
  }
}

resource "google_compute_resource_policy" "persistent_data_snapshot" {
  name        = "gavb-policy-jenkins-persistent-data-snapshot"
  description = "Jenkins persistent data snapshot"

  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "03:00"
      }
    }
    
    retention_policy {
      max_retention_days    = 5
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
  }
}