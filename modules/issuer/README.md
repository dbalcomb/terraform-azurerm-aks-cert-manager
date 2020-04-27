# Issuer

This module configures a certificate issuer that is responsible for making
certificate requests to an Automatic Certificate Management Environment (ACME)
server.

## Usage

```hcl
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

| Name                                   | Type     | Default   | Description                                                  |
| -------------------------------------- | -------- | --------- | ------------------------------------------------------------ |
| `name`                                 | `string` |           | The certificate issuer name                                  |
| `email`                                | `string` |           | The certificate issuer ACME registration email address       |
| `server`                               | `string` | `staging` | The certificate issuer ACME server address                   |
| `kubeconfig`                           | `string` |           | The Kubernetes configuration file contents                   |
| `ingress`                              | `object` | `null`    | The ingress configuration for HTTP challenges                |
| `ingress.class`                        | `string` |           | The ingress class used for automating the validation process |
| `dns_zone`                             | `object` | `null`    | The DNS zone configuration for DNS challenges                |
| `dns_zone.name`                        | `string` |           | The DNS zone name                                            |
| `dns_zone.group`                       | `string` |           | The DNS zone group                                           |
| `dns_service_principal`                | `object` | `null`    | The service principal configuration for DNS challenges       |
| `dns_service_principal.application_id` | `string` |           | The service principal client / application ID                |
| `dns_service_principal.secret`         | `string` |           | The service principal secret                                 |

## Outputs

| Name      | Type     | Description                                            |
| --------- | -------- | ------------------------------------------------------ |
| `name`    | `string` | The certificate issuer name                            |
| `email`   | `string` | The certificate issuer ACME registration email address |
| `server`  | `string` | The certificate issuer ACME server address             |
| `ingress` | `object` | The ingress configuration                              |

## Notes

- This module evaluates the shorthand `production` and `staging` values for the
  `server` variable as the corresponding *Let's Encrypt* environment.
- This module currently requires the `kubectl` command-line utility to be
  installed in the `PATH` and a `kubeconfig` input for *Kubernetes*
  authentication.
