terraform {
  required_version = ">= 1.2.0"
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "4.2.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.12.0"
    }
  }
}
