terraform {
  required_version = ">= 0.12"

  required_providers {
    helm       = ">= 1.0"
    kubernetes = ">= 1.10"
    local      = ">= 1.4"
    null       = ">= 2.1"
  }
}
