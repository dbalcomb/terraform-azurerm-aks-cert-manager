module "cert_manager" {
  source = "../../"

  name       = "cert-manager"
  kubeconfig = "..."
  metrics    = true
}

module "issuer" {
  source = "../../modules/issuer"

  name       = "issuer"
  email      = "daniel.balcomb@gmail.com"
  server     = "staging"
  kubeconfig = "..."

  ingress = {
    class = "traefik"
  }
}
