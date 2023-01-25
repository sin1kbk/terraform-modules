variable "github_owner" {
  type    = string
  default = "github"
}

variable "github_token" {
  type = string
}

variable "admin_password" {
  type    = string
  default = "argocd admin password"
}

variable "application_parameters" {
  description = "These paths will be registered with Argocd application."
  type = list(
    object({
      repository : string
      applications : list(object({
        name : string
        namespace : string
        path : string
        value_files : list(string)
      })),
    })
  )
  default = [
    {
      repository : "terraform-quorum-kubernetes",
      applications : [
        {
          name : "genesis"
          namespace : "quorum"
          path : "quorum-kubernetes/helm/charts/goquorum-genesis"
          value_files : [
            "values.yaml"
          ]
        },
        {
          name : "rpc-node"
          namespace : "quorum"
          path : "quorum-kubernetes/helm/charts/goquorum-genesis"
          value_files : [
            "values.yaml"
          ]
        },
      ]
    },
  ]
}
