# Controller

This module configures the certificate management controller which is
responsible for managing the issuance and lifecycle of certificates.

## Usage

```hcl
module "controller" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-cert-manager//modules/controller"

  name       = "cert-manager"
  kubeconfig = "..."
  metrics    = true
}
```

## Inputs

| Name         | Type     | Default | Description                                |
| ------------ | -------- | ------- | ------------------------------------------ |
| `name`       | `string` |         | The certificate management controller name |
| `kubeconfig` | `string` |         | The Kubernetes configuration file contents |
| `metrics`    | `bool`   | `false` | Enable prometheus metrics                  |

## Outputs

| Name        | Type     | Description                                     |
| ----------- | -------- | ----------------------------------------------- |
| `name`      | `string` | The certificate management controller name      |
| `namespace` | `string` | The certificate management controller namespace |
| `metrics`   | `bool`   | Enable prometheus metrics                       |

## Notes

- This module currently requires the `kubectl` command-line utility to be
  installed in the `PATH` and a `kubeconfig` input for *Kubernetes*
  authentication.
