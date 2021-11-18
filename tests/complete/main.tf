module "cert_manager" {
  source = "../../"

  name    = "cert-manager"
  metrics = true
}

module "issuer_http" {
  source = "../../modules/issuer"

  name   = "issuer"
  email  = "user@example.com"
  server = "staging"

  ingress = {
    class = "nginx"
  }
}

module "issuer_dns" {
  source = "../../modules/issuer"

  name   = "issuer"
  email  = "user@example.com"
  server = "staging"

  dns_zone = {
    name  = "example.com"
    group = "example-rg"
  }

  dns_service_principal = {
    application_id = "..."
    secret         = "..."
  }
}
