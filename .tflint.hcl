plugin "dynatrace" {
  enabled = true
  version = "0.3.0"
  source  = "github.com/dynatrace-oss/tflint-ruleset-dynatrace"
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
}
