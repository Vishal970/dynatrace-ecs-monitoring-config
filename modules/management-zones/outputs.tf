output "zone_id" {
  description = "Dynatrace management zone ID — used to scope alerting profiles"
  value       = dynatrace_management_zone_v2.app_env.id
}

output "zone_name" {
  value = dynatrace_management_zone_v2.app_env.name
}
