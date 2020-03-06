data "helm_repository" "main" {
  name = "jetstack"
  url  = "https://charts.jetstack.io"
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
}
