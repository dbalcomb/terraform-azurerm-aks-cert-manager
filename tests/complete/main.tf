module "cert_manager" {
  source = "../../"

  name    = "cert-manager"
  metrics = true
}

module "issuer_http" {
  source = "../../modules/issuer"

  name   = "issuer"
  email  = "daniel.balcomb@gmail.com"
  server = "staging"

  ingress = {
    class = "traefik"
  }
}

module "issuer_dns" {
  source = "../../modules/issuer"

  name   = "issuer"
  email  = "daniel.balcomb@gmail.com"
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
