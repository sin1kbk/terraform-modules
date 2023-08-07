terraform {
  #backend "local" { path = ".tfstate" }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "kubokkey"

    workspaces {
      name = "aws"
    }
  }
}