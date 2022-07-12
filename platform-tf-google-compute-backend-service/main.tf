resource "google_compute_region_backend_service" "region_backend_service" {
  count = var.create_module && var.regional ? 1 : 0

  name = local.name

  affinity_cookie_ttl_sec         = var.affinity_cookie_ttl_sec
  connection_draining_timeout_sec = var.connection_draining_timeout_sec
  description                     = var.description
  enable_cdn                      = var.enable_cdn
  health_checks                   = var.health_checks
  load_balancing_scheme           = var.load_balancing_scheme
  locality_lb_policy              = var.locality_lb_policy
  port_name                       = var.port_name
  protocol                        = var.protocol
  session_affinity                = var.session_affinity
  timeout_sec                     = var.timeout_sec
  network                         = var.network
  region                          = var.region
  project                         = var.project

  dynamic "backend" {
    for_each = var.backend

    content {
      group                        = backend.value.group
      capacity_scaler              = lookup(backend.value, "capacity_scaler", null)
      balancing_mode               = lookup(backend.value, "balancing_mode", "CONNECTION")
      description                  = lookup(backend.value, "description", null)
      failover                     = lookup(backend.value, "failover", null)
      max_connections              = lookup(backend.value, "max_connections", null)
      max_connections_per_instance = lookup(backend.value, "max_connections_per_instance", null)
      max_connections_per_endpoint = lookup(backend.value, "max_connections_per_endpoint", null)
      max_rate                     = lookup(backend.value, "max_rate", null)
      max_rate_per_instance        = lookup(backend.value, "max_rate_per_instance", null)
      max_rate_per_endpoint        = lookup(backend.value, "max_rate_per_endpoint", null)
      max_utilization              = lookup(backend.value, "max_utilization", null)
    }
  }

  dynamic "circuit_breakers" {
    for_each = length(keys(var.circuit_breakers)) > 0 ? [var.circuit_breakers] : []

    content {
      max_requests_per_connection = lookup(circuite_breakers.value, "max_requests_per_connection", null)
      max_connections             = lookup(circuite_breakers.value, "max_connections", 1024)
      max_pending_requests        = lookup(circuite_breakers.value, "max_pending_requests", 1024)
      max_requests                = lookup(circuite_breakers.value, "max_requests", 1024)
      max_retries                 = lookup(circuite_breakers.value, "max_retries", 3)
    }
  }

  dynamic "consistent_hash" {
    for_each = length(keys(var.consistent_hash)) > 0 ? [var.consistent_hash] : []

    content {
      http_header_name  = lookup(consistent_hash.value, "http_header_name", null)
      minimum_ring_size = lookup(consistent_hash.value, "minimum_ring_size", 1024)

      dynamic "http_cookie" {
        for_each = length(keys(lookup(consistent_hash.value, "http_cookie", {}))) > 0 ? [lookup(consistent_hash.value, "http_cookie", {})] : []

        content {
          name = lookup(http_cookie.value, "name", null)
          path = lookup(http_cookie.value, "path", null)

          dynamic "ttl" {
            for_each = length(keys(lookup(http_cookie.value, "ttl", {}))) > 0 ? [lookup(http_cookie.value, "ttl", {})] : []

            content {
              seconds = ttl.value.seconds
              nanos   = lookup(ttl.value, "nanos", null)
            }
          }
        }
      }
    }
  }

  dynamic "cdn_policy" {
    for_each = length(keys(var.cdn_policy)) > 0 ? [var.cdn_policy] : []

    content {
      signed_url_cache_max_age_sec = lookup(cdn_policy.value, "signed_url_cache_max_age_sec", null)
      default_ttl                  = lookup(cdn_policy.value, "default_ttl", null)
      max_ttl                      = lookup(cdn_policy.value, "max_ttl", null)
      client_ttl                   = lookup(cdn_policy.value, "client_ttl", null)
      negative_caching             = lookup(cdn_policy.value, "negative_caching", null)
      cache_mode                   = lookup(cdn_policy.value, "cache_mode", null)
      serve_while_stale            = lookup(cdn_policy.value, "serve_while_stale", null)

      dynamic "cache_key_policy" {
        for_each = length(keys(lookup(cdn_policy.value, "cache_key_policy", {}))) > 0 ? [lookup(cdn_policy.value, "cache_key_policy", {})] : []

        content {
          include_host           = lookup(cache_key_policy.value, "include_host", null)
          include_protocol       = lookup(cache_key_policy.value, "include_protocol", null)
          include_query_string   = lookup(cache_key_policy.value, "include_query_string", null)
          query_string_blacklist = lookup(cache_key_policy.value, "query_string_blacklist", null)
          query_string_whitelist = lookup(cache_key_policy.value, "query_string_whitelist", null)
        }
      }

      dynamic "negative_caching_policy" {
        for_each = lookup(cdn_policy.value, "negative_caching_policy", [])

        content {
          code = lookup(negative_caching_policy.value, "code", null)
          # TBD: define ttl. Currently it's only used by the beta provider
        }
      }
    }
  }

  dynamic "failover_policy" {
    for_each = length(keys(var.failover_policy)) > 0 ? [var.failover_policy] : []

    content {
      disable_connection_drain_on_failover = lookup(failover_policy.value, "disable_connection_drain_on_failover", null)
      drop_traffic_if_unhealthy            = lookup(failover_policy.value, "drop_traffic_if_unhealthy", null)
      failover_ratio                       = lookup(failover_policy.value, "failover_ratio", null)
    }
  }

  dynamic "outlier_detection" {
    for_each = length(keys(var.failover_policy)) > 0 ? [var.failover_policy] : []

    content {
      consecutive_errors                    = lookup(outlier_detection.value, "consecutive_errors", 5)
      consecutive_gateway_failure           = lookup(outlier_detection.value, "consecutive_gateway_failure", 5)
      enforcing_consecutive_errors          = lookup(outlier_detection.value, "enforcing_consecutive_errors", 100)
      enforcing_consecutive_gateway_failure = lookup(outlier_detection.value, "enforcing_consecutive_gateway_failure", 0)
      enforcing_success_rate                = lookup(outlier_detection.value, "enforcing_success_rate", 100)
      max_ejection_percent                  = lookup(outlier_detection.value, "max_ejection_percent ", 10)
      success_rate_minimum_hosts            = lookup(outlier_detection.value, "success_rate_minimum_hosts ", 5)
      success_rate_request_volume           = lookup(outlier_detection.value, "success_rate_request_volume ", 100)
      success_rate_stdev_factor             = lookup(outlier_detection.value, "success_rate_stdev_factor ", 100)

      dynamic "base_ejection_time" {
        for_each = length(keys(lookup(outlier_detection.value, "base_ejection_time", {}))) > 0 ? [lookup(outlier_detection.value, "base_ejection_time", {})] : []

        content {
          seconds = base_ejection_time.value.seconds
          nanos   = lookup(base_ejection_time.value, "nanos", null)
        }
      }

      dynamic "interval" {
        for_each = length(keys(lookup(outlier_detection.value, "interval", {}))) > 0 ? [lookup(outlier_detection.value, "interval", {})] : []

        content {
          seconds = interval.value.seconds
          nanos   = lookup(interval.value, "nanos", null)
        }
      }
    }
  }

  dynamic "log_config" {
    for_each = length(keys(var.log_config)) > 0 ? [var.log_config] : []

    content {
      enable      = lookup(log_config.value, "enable", true)
      sample_rate = lookup(log_config.value, "sample_rate", 1.0)
    }
  }
}

resource "google_compute_backend_service" "backend_service" {
  count = var.create_module && !var.regional ? 1 : 0

  name = local.name
}