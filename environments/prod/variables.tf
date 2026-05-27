variable "dt_env_url" {
  description = "Dynatrace environment URL"
  type        = string
}

variable "dt_api_token" {
  description = "Dynatrace API token"
  type        = string
  sensitive   = true
}

variable "app_name" {
  type = string
}

variable "team" {
  type = string
}

variable "timezone" {
  type    = string
  default = "UTC"
}

variable "slack_webhook_p1" {
  type      = string
  sensitive = true
}

variable "slack_webhook_p2" {
  type      = string
  sensitive = true
}

variable "pagerduty_api_key" {
  type      = string
  sensitive = true
}

variable "services" {
  type = map(object({
    entity_id                    = string
    response_time_threshold_ms   = number
    error_rate_threshold_percent = number
  }))
}
