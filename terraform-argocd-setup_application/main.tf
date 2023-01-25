resource "tls_private_key" "argocd" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "github_repository" "x" {
  for_each  = { for i in var.application_parameters : i.repository => i }
  full_name = "${var.github_owner}/${each.value.repository}"
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
locals {
  flatten_application_parameter = distinct(flatten([
    for application_parameter in var.application_parameters : [
      for application in application_parameter.applications : {
        name : application.name
        namespace : application.namespace
        repository : application_parameter.repository
        path : application.path
        value_files : application.value_files
      }
    ]
  ]))
}

resource "argocd_application" "x" {
  depends_on = [argocd_repository.x]

  for_each = { for i in local.flatten_application_parameter : i.name => i }
  metadata {
    name      = basename(each.value.name)
    namespace = "argocd"
  }

  spec {
    source {
      repo_url        = "git@github.com:${var.github_owner}/${each.value.repository}"
      path            = each.value.path
      target_revision = "HEAD"
      helm {
        value_files = each.value.value_files
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = each.value.namespace
    }
  }
}
