resource "dynatrace_autotag_v2" "app" {
  name = "app"

  rules {
    rule {
      type    = "ME"
      enabled = true

      attribute_rule {
        entity_type = "ECS_CONTAINER_INSTANCE"

        attribute_conditions {
          condition {
            case_sensitive = false
            key            = "AWS_ECS_TASK_DEFINITION_FAMILY"
            operator       = "EXISTS"
          }
        }
      }

      value_format = "{ECSTaskFamily}"
    }
  }
}

resource "dynatrace_autotag_v2" "environment" {
  name = "env"

  rules {
    rule {
      type    = "ME"
      enabled = true

      attribute_rule {
        entity_type = "ECS_CONTAINER_INSTANCE"

        attribute_conditions {
          condition {
            case_sensitive = false
            key            = "AWS_ECS_TASK_DEFINITION_FAMILY"
            operator       = "EXISTS"
          }
        }
      }

      value_format = "{ProcessGroupTag:env}"
    }
  }
}

resource "dynatrace_autotag_v2" "team" {
  name = "team"

  rules {
    rule {
      type    = "ME"
      enabled = true

      attribute_rule {
        entity_type = "SERVICE"

        attribute_conditions {
          condition {
            case_sensitive = false
            key            = "SERVICE_TAGS"
            operator       = "TAG_KEY_EXISTS"
            tag_key        = "team"
          }
        }
      }

      value_format = "{Tag:team}"
    }
  }
}

resource "dynatrace_autotag_v2" "version" {
  name = "version"

  rules {
    rule {
      type    = "ME"
      enabled = true

      attribute_rule {
        entity_type = "CONTAINER_GROUP_INSTANCE"

        attribute_conditions {
          condition {
            case_sensitive = false
            key            = "DOCKER_IMAGE_VERSION"
            operator       = "EXISTS"
          }
        }
      }

      value_format = "{DockerImageVersion}"
    }
  }
}
