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
  description = "The ingress configuration"
  type = object({
    class = string
  })
}
