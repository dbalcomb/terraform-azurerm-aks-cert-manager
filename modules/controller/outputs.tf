output "name" {
  description = "The certificate management controller name"
  value       = helm_release.main.metadata.0.name
}

output "namespace" {
  description = "The certificate management controller namespace"
  value       = kubernetes_namespace.main.metadata.0.name
}
