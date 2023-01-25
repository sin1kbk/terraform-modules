# terraform-argocd-setup_application

## sample

```hcl2
module "install" {
  source  = "app.terraform.io/kubokkey/install/argocd"
  version = "1.0.0"

  application_parameters = [
    {
      repository : "quorum-kubernetes",
      applications : [
        {
          name : "genesis"
          namespace : "quorum"
          path : "goquorum-genesis"
          value_files : [
            "genesis-values.yaml"
          ]
        },
        {
          name : "rpc-1"
          namespace : "quorum"
          path : "goquorum-node"
          value_files : [
            "reader-values.yaml",
            "dev-values.yaml"
          ]
        },
        {
          name : "member-1"
          namespace : "quorum"
          path : "goquorum-node"
          value_files : [
            "txnode-values.yaml",
            "dev-values.yaml"
          ]
        },
        {
          name : "validator-1"
          namespace : "quorum"
          path : "goquorum-node"
          value_files : [
            "validator-values.yaml",
            "dev-values.yaml"
          ]
        },
        {
          name : "validator-2"
          namespace : "quorum"
          path : "goquorum-node"
          value_files : [
            "validator-values.yaml",
            "dev-values.yaml"
          ]
        },
        {
          name : "validator-3"
          namespace : "quorum"
          path : "goquorum-node"
          value_files : [
            "validator-values.yaml",
            "dev-values.yaml"
          ]
        },
      ]
    },
  ]
```
