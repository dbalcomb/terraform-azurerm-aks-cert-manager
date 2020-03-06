module "controller" {
  source = "./modules/controller"

  name    = var.name
  metrics = var.metrics
}
