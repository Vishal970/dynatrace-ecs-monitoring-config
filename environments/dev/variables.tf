variable "dt_env_url" {
  description = "Dynatrace environment URL (e.g. https://XXXXXXXXXX.live.dynatrace.com)"
  type        = string
}

variable "dt_api_token" {
  description = "Dynatrace API token with WriteConfig, ReadConfig, DataExport scopes"
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

variable "services" {
  description = "Map of service names to their Dynatrace entity IDs and alert thresholds"
  type = map(object({
    entity_id                    = string
    response_time_threshold_ms   = number
    error_rate_threshold_percent = number
  }))
}
