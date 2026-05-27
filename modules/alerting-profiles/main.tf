resource "dynatrace_alerting" "p1_critical" {
  name            = "${var.zone_name} – P1 Critical"
  management_zone = var.management_zone_id

  rules {
    rule {
      include_mode     = "INCLUDE_ALL"
      delay_in_minutes = 0
      severity_level   = "AVAILABILITY"
    }
    rule {
      include_mode     = "INCLUDE_ALL"
      delay_in_minutes = 0
      severity_level   = "ERROR"
    }
  }
}

resource "dynatrace_alerting" "p2_warning" {
  name            = "${var.zone_name} – P2 Warning"
  management_zone = var.management_zone_id

  rules {
    rule {
      include_mode     = "INCLUDE_ALL"
      delay_in_minutes = 5
      severity_level   = "PERFORMANCE"
    }
    rule {
      include_mode     = "INCLUDE_ALL"
      delay_in_minutes = 5
      severity_level   = "RESOURCE_CONTENTION"
    }
  }
}

resource "dynatrace_alerting" "p3_info" {
  name            = "${var.zone_name} – P3 Info"
  management_zone = var.management_zone_id

  rules {
    rule {
      include_mode     = "INCLUDE_ALL"
      delay_in_minutes = 15
      severity_level   = "MONITORING_UNAVAILABLE"
    }
  }
}
