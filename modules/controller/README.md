# Controller

This module configures the certificate management controller which is
responsible for managing the issuance and lifecycle of certificates.

## Usage

```hcl
module "controller" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-cert-manager//modules/controller"

  name = "cert-manager"
}
```

## Inputs

| Name   | Type     | Default | Description                                |
| ------ | -------- | ------- | ------------------------------------------ |
| `name` | `string` |         | The certificate management controller name |

## Outputs

| Name        | Type     | Description                                     |
| ----------- | -------- | ----------------------------------------------- |
| `name`      | `string` | The certificate management controller name      |
| `namespace` | `string` | The certificate management controller namespace |

## Notes

- This module currently requires the `kubectl` command-line utility to be
  installed in the `PATH` and a `kubeconfig` file in the current working
  directory for *Kubernetes* authentication.
