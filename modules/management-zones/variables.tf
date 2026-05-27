variable "app_name" {
  description = "Application name — must match ECS task definition tag 'app'"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod) — must match ECS task definition tag 'env'"
  type        = string
}

variable "team" {
  description = "Team name — used for scoping and notification routing"
  type        = string
}
