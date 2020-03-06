# terraform-azurerm-aks-cert-manager

[Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-gb/services/kubernetes-service/)
[Certificate Manager](https://cert-manager.io) Terraform Module.

## Usage

```hcl
module "cert_manager" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-cert-manager"

  name = "cert-manager"
}
```

## Inputs

| Name   | Type     | Default | Description                  |
| ------ | -------- | ------- | ---------------------------- |
| `name` | `string` |         | The certificate manager name |

## Outputs

| Name        | Type     | Description                       |
| ----------- | -------- | --------------------------------- |
| `name`      | `string` | The certificate manager name      |
| `namespace` | `string` | The certificate manager namespace |

## Modules

- [Controller](modules/controller/README.md)
