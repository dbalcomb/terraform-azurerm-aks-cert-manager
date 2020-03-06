data "helm_repository" "main" {
  name = "jetstack"
  url  = "https://charts.jetstack.io"
}

resource "null_resource" "definitions" {
  triggers = {
    hash = sha256(file("${path.module}/templates/definitions.yml"))
  }

  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/templates/definitions.yml --kubeconfig ${path.cwd}/kubeconfig"
  }

  provisioner "local-exec" {
    command = "kubectl delete -f ${path.module}/templates/definitions.yml --kubeconfig ${path.cwd}/kubeconfig"
    when    = destroy
  }
}

resource "kubernetes_namespace" "main" {
  metadata {
    name = var.name

    labels = {
      "cert-manager.io/disable-validation" = "true"
    }
  }
}

resource "helm_release" "main" {
  name       = var.name
  namespace  = kubernetes_namespace.main.metadata.0.name
  repository = data.helm_repository.main.metadata.0.name
  chart      = "cert-manager"
  version    = "0.13"

  depends_on = [
    null_resource.definitions,
  ]
}
