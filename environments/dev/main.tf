terraform {
  backend "s3" {
    bucket         = "myapp-terraform-state-dev"
    key            = "dynatrace/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "myapp-terraform-locks"
    encrypt        = true
  }
}

provider "dynatrace" {
  dt_env_url   = var.dt_env_url
  dt_api_token = var.dt_api_token
}

module "management_zone" {
  source      = "../../modules/management-zones"
  app_name    = var.app_name
  environment = "dev"
  team        = var.team
}

module "alerting" {
  source             = "../../modules/alerting-profiles"
  zone_name          = module.management_zone.zone_name
  management_zone_id = module.management_zone.zone_id
  environment        = "dev"
  timezone           = var.timezone
  enable_pagerduty   = false
  slack_webhook_p1   = var.slack_webhook_p1
  slack_webhook_p2   = var.slack_webhook_p2
}

module "auto_tagging" {
  source = "../../modules/auto-tagging"
}

module "metric_events" {
  for_each = var.services

  source            = "../../modules/metric-events"
  service_name      = each.key
  service_entity_id = each.value.entity_id

  # 2x looser thresholds in dev — avoid paging for expected dev variability
  response_time_threshold_ms   = each.value.response_time_threshold_ms * 2
  error_rate_threshold_percent = each.value.error_rate_threshold_percent * 2
}
