output "p1_profile_id" {
  value = dynatrace_alerting.p1_critical.id
}

output "p2_profile_id" {
  value = dynatrace_alerting.p2_warning.id
}

output "p3_profile_id" {
  value = dynatrace_alerting.p3_info.id
}
