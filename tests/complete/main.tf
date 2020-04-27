module "cert_manager" {
  source = "../../"

  name       = "cert-manager"
  kubeconfig = "..."
  metrics    = true
}

module "issuer_http" {
  source = "../../modules/issuer"

  name       = "issuer"
  email      = "daniel.balcomb@gmail.com"
  server     = "staging"
  kubeconfig = "..."

  ingress = {
    class = "traefik"
  }
}

module "issuer_dns" {
  source = "../../modules/issuer"

  name       = "issuer"
  email      = "daniel.balcomb@gmail.com"
  server     = "staging"
  kubeconfig = "..."

  dns_zone = {
    name  = "example.com"
    group = "example-rg"
  }

  dns_service_principal = {
    application_id = "..."
    secret         = "..."
  }
}
