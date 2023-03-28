terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.43.0"
    }
  }
}

provider "tfe" {}

resource "tfe_organization" "kubokkey" {
  name  = "kubokkey"
  email = var.email
  collaborator_auth_policy = "two_factor_mandatory"
}

resource "tfe_oauth_client" "github" {
  organization = tfe_organization.kubokkey.name
  api_url = "https://api.github.com"
  http_url = "https://github.com"
  service_provider = "github"
  oauth_token = var.github_personal_access_token
}
