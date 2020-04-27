locals {
  dns_challenge = var.dns_zone != null && var.dns_service_principal != null
}

data "azurerm_client_config" "main" {
  count = local.dns_challenge ? 1 : 0
}

locals {
  servers = {
    production = "https://acme-v02.api.letsencrypt.org/directory"
    staging    = "https://acme-staging-v02.api.letsencrypt.org/directory"
  }
}

locals {
  server = lookup(local.servers, var.server, var.server)
  issuer = templatefile("${path.module}/templates/issuer.yml", {
    name    = var.name
    email   = var.email
    server  = local.server
    ingress = var.ingress

    dns = local.dns_challenge ? {
      secret_name     = kubernetes_secret.secret.0.metadata.0.name
      client_id       = var.dns_service_principal.application_id
      subscription_id = data.azurerm_client_config.main.0.subscription_id
      tenant_id       = data.azurerm_client_config.main.0.tenant_id
      zone            = var.dns_zone
    } : null
  })
}

resource "local_file" "kubeconfig" {
  filename          = "${path.cwd}/kubeconfig"
  file_permission   = "0644"
  sensitive_content = var.kubeconfig
}

resource "kubernetes_secret" "secret" {
  count = local.dns_challenge ? 1 : 0

  metadata {
    name      = format("%s-secret", var.name)
    namespace = "cert-manager"
  }

  data = {
    secret = var.dns_service_principal.secret
  }
}

resource "null_resource" "issuer" {
  triggers = {
    file = base64encode(local.issuer)
  }

  provisioner "local-exec" {
    command = format("kubectl --kubeconfig ${path.cwd}/kubeconfig apply -f - <<EOF\n%s\nEOF", base64decode(self.triggers.file))
  }

  provisioner "local-exec" {
    command = format("kubectl --kubeconfig ${path.cwd}/kubeconfig delete -f - <<EOF\n%s\nEOF", base64decode(self.triggers.file))
    when    = destroy
  }

  depends_on = [
    local_file.kubeconfig,
    kubernetes_secret.secret,
  ]
}
