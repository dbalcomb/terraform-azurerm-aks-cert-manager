terraform {
  required_version = "~> 1.0"

  required_providers {
    helm       = "~> 2.3"
    kubernetes = "~> 2.6"
    local      = "~> 2.1"
    null       = "~> 3.1"
  }
}
