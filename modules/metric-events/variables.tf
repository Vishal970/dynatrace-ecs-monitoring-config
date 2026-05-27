variable "service_name" {
  description = "Human-readable service name used in alert summaries"
  type        = string
}

variable "service_entity_id" {
  description = "Dynatrace service entity ID (format: SERVICE-XXXXXXXXXXXXXXXX)"
  type        = string
}

variable "response_time_threshold_ms" {
  description = "P95 response time threshold in microseconds (1000000 = 1 second)"
  type        = number
  default     = 2000000
}

variable "error_rate_threshold_percent" {
  description = "Error rate percentage threshold to trigger alert (e.g. 5 = 5%)"
  type        = number
  default     = 5
}
