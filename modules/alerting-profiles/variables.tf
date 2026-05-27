variable "zone_name" {
  description = "Management zone name — used as prefix in alerting profile names"
  type        = string
}

variable "management_zone_id" {
  description = "Dynatrace management zone ID to scope these alerting profiles"
  type        = string
}

variable "environment" {
  description = "Environment (dev or prod) — controls PagerDuty enablement"
  type        = string
}

variable "timezone" {
  description = "Timezone for P3 business-hours filter (e.g. America/New_York, Asia/Kolkata)"
  type        = string
  default     = "UTC"
}

variable "enable_pagerduty" {
  description = "Enable PagerDuty routing for P1 alerts — false in dev"
  type        = bool
  default     = false
}

variable "slack_webhook_p1" {
  description = "Slack webhook URL for P1 critical alerts"
  type        = string
  sensitive   = true
}

variable "slack_webhook_p2" {
  description = "Slack webhook URL for P2 warning alerts"
  type        = string
  sensitive   = true
}

variable "pagerduty_api_key" {
  description = "PagerDuty integration key — leave empty string to disable"
  type        = string
  sensitive   = true
  default     = ""
}
