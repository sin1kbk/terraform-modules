terraform {
  #backend "local" { path = ".tfstate" }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "kubokkey"

    workspaces {
      name = "terraform-modules"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.56.0"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "3.15.0"
    }
  }
}