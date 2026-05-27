terraform {
  backend "s3" {
    bucket         = "myapp-terraform-state-prod"
    key            = "dynatrace/prod/terraform.tfstate"
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
  environment = "prod"
  team        = var.team
}

module "alerting" {
  source             = "../../modules/alerting-profiles"
  zone_name          = module.management_zone.zone_name
  management_zone_id = module.management_zone.zone_id
  environment        = "prod"
  timezone           = var.timezone
  enable_pagerduty   = true
  slack_webhook_p1   = var.slack_webhook_p1
  slack_webhook_p2   = var.slack_webhook_p2
  pagerduty_api_key  = var.pagerduty_api_key
}

module "auto_tagging" {
  source = "../../modules/auto-tagging"
}

module "metric_events" {
  for_each = var.services

  source            = "../../modules/metric-events"
  service_name      = each.key
  service_entity_id = each.value.entity_id

  response_time_threshold_ms   = each.value.response_time_threshold_ms
  error_rate_threshold_percent = each.value.error_rate_threshold_percent
}
