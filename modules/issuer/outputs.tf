output "name" {
  description = "The certificate issuer name"
  value       = var.name
}

output "email" {
  description = "The certificate issuer ACME registration email address"
  value       = var.email
}

output "server" {
  description = "The certificate issuer ACME server address"
  value       = local.server
}

output "ingress" {
  description = "The ingress configuration"
  value       = var.ingress
}
