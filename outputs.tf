output "name" {
  description = "The certificate manager name"
  value       = module.controller.name
}

output "namespace" {
  description = "The certificate manager namespace"
  value       = module.controller.namespace
}

output "metrics" {
  description = "Enable prometheus metrics"
  value       = var.metrics
}
