module "cert_manager" {
  source = "../../"

  name    = "cert-manager"
  metrics = true
}

module "issuer" {
  source = "../../modules/issuer"

  name   = "issuer"
  email  = "daniel.balcomb@gmail.com"
  server = "staging"

  ingress = {
    class = "traefik"
  }
}
