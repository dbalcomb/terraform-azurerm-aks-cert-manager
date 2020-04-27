variable "name" {
  description = "The certificate issuer name"
  type        = string
}

variable "email" {
  description = "The certificate issuer ACME registration email address"
  type        = string
}

variable "server" {
  description = "The certificate issuer ACME server address"
  default     = "staging"
  type        = string
}

variable "kubeconfig" {
  description = "The Kubernetes configuration file contents"
  type        = string
}

variable "ingress" {
  description = "The ingress configuration for HTTP challenges"
  default     = null
  type = object({
    class = string
  })
}

variable "dns_zone" {
  description = "The DNS zone configuration for DNS challenges"
  default     = null
  type = object({
    name  = string
    group = string
  })
}

variable "dns_service_principal" {
  description = "The service principal configuration for DNS challenges"
  default     = null
  type = object({
    application_id = string
    secret         = string
  })
}
