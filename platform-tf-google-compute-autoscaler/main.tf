resource "google_compute_region_autoscaler" "region_autoscaler" {
  count = var.create_module && var.regional ? 1 : 0

  name        = local.name
  description = var.description
  region      = var.region
  project     = var.project
  target      = var.target

  dynamic "autoscaling_policy" {
    for_each = [var.autoscaling_policy]

    content {
      min_replicas    = autoscaling_policy.value.min_replicas
      max_replicas    = autoscaling_policy.value.max_replicas
      cooldown_period = lookup(autoscaling_policy.value, "cooldown_period", null)
      mode            = lookup(autoscaling_policy.value, "mode", "ON")

      dynamic "scale_in_control" {
        for_each = length(keys(lookup(autoscaling_policy.value, "scale_in_control", {}))) > 0 ? [lookup(autoscaling_policy.value, "scale_in_control", {})] : []

        content {
          time_window_sec = lookup(scale_in_control.value, "time_window_sec", null)

          dynamic "max_scaled_in_replicas" {
            for_each = length(keys(lookup(scale_in_control.value, "max_scaled_in_replicas", {}))) > 0 ? [lookup(scale_in_control.value, "max_scaled_in_replicas", {})] : []

            content {
              fixed   = lookup(max_scaled_in_replicas.value, "fixed", null)
              percent = lookup(max_scaled_in_replicas.value, "percent", null)
            }
          }
        }
      }

      dynamic "cpu_utilization" {
        for_each = length(keys(lookup(autoscaling_policy.value, "cpu_utilization", {}))) > 0 ? [lookup(autoscaling_policy.value, "cpu_utilization", {})] : []

        content {
          target            = cpu_utilization.value.target
          predictive_method = lookup(cpu_utilization.value, "predictive_method", "NONE")
        }
      }

      dynamic "metric" {
        for_each = lookup(autoscaling_policy.value, "metric", [])

        content {
          name   = metric.value.name
          target = lookup(metric.value, "target", null)
          type   = lookup(metric.value, "type", null)
        }
      }

      dynamic "load_balancing_utilization" {
        for_each = length(keys(lookup(autoscaling_policy.value, "load_balancing_utilization", {}))) > 0 ? [lookup(autoscaling_policy.value, "load_balancing_utilization", {})] : []

        content {
          target = load_balancing_utilization.value.target
        }
      }

      dynamic "scaling_schedules" {
        for_each = { for v in lookup(autoscaling_policy.value, "scaling_schedules", []) : v.name => v }

        content {
          name                  = scaling_schedules.key
          min_required_replicas = scaling_schedules.value.min_required_replicas
          schedule              = scaling_schedules.value.schedule
          duration_sec          = lookup(scaling_schedules.value, "duration_sec", 300)
          time_zone             = lookup(scaling_schedules.value, "time_zone", "America/Sao_Paulo")
          disabled              = lookup(scaling_schedules.value, "disabled", false)
          description           = lookup(scaling_schedules.value, "description", null)
        }
      }
    }
  }
}

resource "google_compute_autoscaler" "autoscaler" {
  count = var.create_module && !var.regional ? 1 : 0

  name        = local.name
  description = var.description
  zone        = var.zone
  project     = var.project
  target      = var.target

  dynamic "autoscaling_policy" {
    for_each = [var.autoscaling_policy]

    content {
      min_replicas    = autoscaling_policy.value.min_replicas
      max_replicas    = autoscaling_policy.value.max_replicas
      cooldown_period = lookup(autoscaling_policy.value, "cooldown_period", null)
      mode            = lookup(autoscaling_policy.value, "mode", "ON")

      dynamic "scale_in_control" {
        for_each = length(keys(lookup(autoscaling_policy.value, "scale_in_control", {}))) > 0 ? [lookup(autoscaling_policy.value, "scale_in_control", {})] : []

        content {
          time_window_sec = lookup(scale_in_control.value, "time_window_sec", null)

          dynamic "max_scaled_in_replicas" {
            for_each = length(keys(lookup(scale_in_control.value, "max_scaled_in_replicas", {}))) > 0 ? [lookup(scale_in_control.value, "max_scaled_in_replicas", {})] : []

            content {
              fixed   = lookup(max_scaled_in_replicas.value, "fixed", null)
              percent = lookup(max_scaled_in_replicas.value, "percent", null)
            }
          }
        }
      }

      dynamic "cpu_utilization" {
        for_each = length(keys(lookup(autoscaling_policy.value, "cpu_utilization", {}))) > 0 ? [lookup(autoscaling_policy.value, "cpu_utilization", {})] : []

        content {
          target            = cpu_utilization.value.target
          predictive_method = lookup(cpu_utilization.value, "predictive_method", "NONE")
        }
      }

      dynamic "metric" {
        for_each = lookup(autoscaling_policy.value, "metric", [])

        content {
          name   = metric.value.name
          target = lookup(metric.value, "target", null)
          type   = lookup(metric.value, "type", null)
        }
      }

      dynamic "load_balancing_utilization" {
        for_each = length(keys(lookup(autoscaling_policy.value, "load_balancing_utilization", {}))) > 0 ? [lookup(autoscaling_policy.value, "load_balancing_utilization", {})] : []

        content {
          target = load_balancing_utilization.value.target
        }
      }

      dynamic "scaling_schedules" {
        for_each = { for v in lookup(autoscaling_policy.value, "scaling_schedules", []) : v.name => v }

        content {
          name                  = scaling_schedules.key
          min_required_replicas = scaling_schedules.value.min_required_replicas
          schedule              = scaling_schedules.value.schedule
          duration_sec          = lookup(scaling_schedules.value, "duration_sec", 300)
          time_zone             = lookup(scaling_schedules.value, "time_zone", "America/Sao_Paulo")
          disabled              = lookup(scaling_schedules.value, "disabled", false)
          description           = lookup(scaling_schedules.value, "description", null)
        }
      }
    }
  }
}
