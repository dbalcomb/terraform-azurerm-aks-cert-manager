variable "name" {
  description = "The certificate management controller name"
  type        = string
}

variable "kubeconfig" {
  description = "The Kubernetes configuration file contents"
  type        = string
}

variable "metrics" {
  description = "Enable prometheus metrics"
  default     = false
  type        = bool
}
