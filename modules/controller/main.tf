resource "kubernetes_namespace" "main" {
  metadata {
    name = var.name

    labels = {
      "cert-manager.io/disable-validation" = "true"
    }
  }
}

locals {
  metrics = {
    "prometheus.enabled"                    = "true"
    "podAnnotations.prometheus\\.io/scrape" = "true"
    "podAnnotations.prometheus\\.io/path"   = "/metrics"
    "podAnnotations.prometheus\\.io/port"   = "9402"
  }
}

resource "helm_release" "main" {
  name       = var.name
  namespace  = kubernetes_namespace.main.metadata.0.name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.6.1"

  set {
    name  = "installCRDs"
    value = "true"
  }

  dynamic "set" {
    for_each = var.metrics ? local.metrics : {}

    content {
      name  = set.key
      value = set.value
    }
  }
}
