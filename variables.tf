variable "name" {
  description = "The certificate manager name"
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
