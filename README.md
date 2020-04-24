# terraform-azurerm-aks-cert-manager

[Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-gb/services/kubernetes-service/)
[Certificate Manager](https://cert-manager.io) Terraform Module.

## Usage

```hcl
module "cert_manager" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-cert-manager"

  name       = "cert-manager"
  kubeconfig = "..."
  metrics    = true
}

module "issuer" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-cert-manager//modules/issuer"

  name       = "issuer"
  email      = "daniel.balcomb@gmail.com"
  server     = "production"
  kubeconfig = "..."

  ingress = {
    class = "traefik"
  }
}
```

## Inputs

| Name         | Type     | Default | Description                                |
| ------------ | -------- | ------- | ------------------------------------------ |
| `name`       | `string` |         | The certificate manager name               |
| `kubeconfig` | `string` |         | The Kubernetes configuration file contents |
| `metrics`    | `bool`   | `false` | Enable prometheus metrics                  |

## Outputs

| Name        | Type     | Description                       |
| ----------- | -------- | --------------------------------- |
| `name`      | `string` | The certificate manager name      |
| `namespace` | `string` | The certificate manager namespace |
| `metrics`   | `bool`   | Enable prometheus metrics         |

## Modules

- [Controller](modules/controller/README.md)
- [Issuer](modules/issuer/README.md)
