variable "repository_and_paths" {
  type = map(any)
  default = {
    0 : {
      repository : "kubokkey/terraform-quorum-kubernetes",
      paths : [
        "quorum-kubernetes/helm/charts/goquorum-genesis",
        "quorum-kubernetes/helm/charts/goquorum-node",
      ]
    },
  }
  description = "These paths will be registered with Argocd application."
}

variable "admin_password" {
  type    = string
  default = "argocd admin password"
}