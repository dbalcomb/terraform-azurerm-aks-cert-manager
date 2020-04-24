module "controller" {
  source = "./modules/controller"

  name       = var.name
  kubeconfig = var.kubeconfig
  metrics    = var.metrics
}
