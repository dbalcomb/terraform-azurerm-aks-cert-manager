terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm    = "~> 2.83"
    kubernetes = "~> 2.6"
    local      = "~> 2.1"
    null       = "~> 3.1"
  }
}
