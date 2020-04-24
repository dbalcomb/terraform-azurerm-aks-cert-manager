locals {
  servers = {
    production = "https://acme-v02.api.letsencrypt.org/directory"
    staging    = "https://acme-staging-v02.api.letsencrypt.org/directory"
  }
}

locals {
  server = lookup(local.servers, var.server, var.server)
  issuer = templatefile("${path.module}/templates/issuer.yml", {
    name          = var.name
    email         = var.email
    server        = local.server
    ingress_class = var.ingress.class
  })
}

resource "local_file" "kubeconfig" {
  filename          = "${path.cwd}/kubeconfig"
  file_permission   = "0644"
  sensitive_content = var.kubeconfig
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
  ]
}
