locals {
  flatten_repository_and_paths = distinct(flatten([
    for each_repository_and_paths in var.repository_and_paths : [
      for path in each_repository_and_paths.paths : {
        repository = each_repository_and_paths.repository
        path       = path
      }
    ]
  ]))
}

resource "tls_private_key" "argocd" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "github_repository" "x" {
  for_each  = var.repository_and_paths
  full_name = each.value.repository
}

resource "github_repository_deploy_key" "argocd_deploy_key" {
  for_each   = data.github_repository.x
  title      = "ArgoCD"
  repository = each.value.name
  key        = tls_private_key.argocd.public_key_openssh
  read_only  = "true"
}

resource "argocd_repository" "x" {
  for_each        = data.github_repository.x
  name            = each.value.name
  repo            = "git@github.com:${each.value.full_name}"
  username        = "git"
  ssh_private_key = tls_private_key.argocd.private_key_openssh
}

# ArgoCD Application define
resource "argocd_application" "x" {
  depends_on = [argocd_repository.x]

  for_each  = { for i in local.flatten_repository_and_paths : i.path => i }
  metadata {
    name      = basename(each.value.path)
    namespace = "argocd"
  }

  spec {
    source {
      repo_url        = "git@github.com:${each.value.repository}"
      path            = each.value.path
      target_revision = "main"
      helm {
        value_files = ["values.yaml"]
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }
  }
}
