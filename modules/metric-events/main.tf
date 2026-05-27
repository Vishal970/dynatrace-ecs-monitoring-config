resource "dynatrace_metric_events" "response_time_p95" {
  enabled      = true
  event_type   = "PERFORMANCE"
  summary      = "${var.service_name} – P95 response time degraded"
  description  = "P95 response time exceeded ${var.response_time_threshold_ms}ms for 3 consecutive 1-minute windows"

  model_properties {
    type               = "STATIC_THRESHOLD"
    threshold          = var.response_time_threshold_ms
    alert_condition    = "ABOVE"
    alert_on_no_data   = false
    dealerting_samples = 3
    samples            = 3
    violating_samples  = 3
  }

  metric_selector = "builtin:service.response.time:percentile(95):filter(and(eq(\"dt.entity.service\",\"${var.service_entity_id}\")))"

  event_entity_dimension_key = "dt.entity.service"

  metadata {
    display_name = "P95 Response Time"
    unit         = "MicroSecond"
  }
}

resource "dynatrace_metric_events" "error_rate" {
  enabled      = true
  event_type   = "ERROR"
  summary      = "${var.service_name} – Error rate elevated"
  description  = "Request error rate exceeded ${var.error_rate_threshold_percent}% for 3 consecutive windows"

  model_properties {
    type               = "STATIC_THRESHOLD"
    threshold          = var.error_rate_threshold_percent
    alert_condition    = "ABOVE"
    alert_on_no_data   = false
    dealerting_samples = 3
    samples            = 3
    violating_samples  = 3
  }

  metric_selector = "builtin:service.errors.total.rate:filter(and(eq(\"dt.entity.service\",\"${var.service_entity_id}\")))"

  event_entity_dimension_key = "dt.entity.service"

  metadata {
    display_name = "Error Rate %"
    unit         = "Percent"
  }
}

resource "dynatrace_metric_events" "request_rate_drop" {
  enabled      = true
  event_type   = "AVAILABILITY"
  summary      = "${var.service_name} – Throughput dropped (possible upstream failure)"
  description  = "Request rate dropped more than 50% from baseline — possible upstream dependency failure or traffic cut"

  model_properties {
    type               = "AUTO_ADAPTIVE_BASELINE"
    alert_condition    = "BELOW"
    alert_on_no_data   = true
    dealerting_samples = 5
    samples            = 5
    violating_samples  = 5
    signal_fluctuations = 1.0
  }

  metric_selector = "builtin:service.requestCount.total:filter(and(eq(\"dt.entity.service\",\"${var.service_entity_id}\")))"

  event_entity_dimension_key = "dt.entity.service"

  metadata {
    display_name = "Request Rate"
    unit         = "PerMinute"
  }
}
