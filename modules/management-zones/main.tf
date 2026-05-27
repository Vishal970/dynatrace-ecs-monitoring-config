resource "dynatrace_management_zone_v2" "app_env" {
  name = "${var.app_name}-${var.environment}"

  rules {
    rule {
      type            = "ME"
      enabled         = true
      entity_selector = "type(SERVICE),tag(app:${var.app_name}),tag(env:${var.environment})"
    }

    rule {
      type            = "ME"
      enabled         = true
      entity_selector = "type(PROCESS_GROUP_INSTANCE),tag(app:${var.app_name}),tag(env:${var.environment})"
    }

    rule {
      type            = "ME"
      enabled         = true
      entity_selector = "type(CONTAINER_GROUP_INSTANCE),tag(app:${var.app_name}),tag(env:${var.environment})"
    }
  }
}
