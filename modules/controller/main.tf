resource "local_file" "kubeconfig" {
  filename          = "${path.cwd}/kubeconfig"
  file_permission   = "0644"
  sensitive_content = var.kubeconfig
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

  depends_on = [
    local_file.kubeconfig,
  ]
}

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
  version    = "0.13"

  dynamic "set" {
    for_each = var.metrics ? local.metrics : {}

    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [
    null_resource.definitions,
  ]
}
