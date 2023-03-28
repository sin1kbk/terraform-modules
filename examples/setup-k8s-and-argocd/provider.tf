terraform {
  backend "local" { path = "./terraform.tfstate" }
  required_version = ">= 1.2.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
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

provider "kubernetes" {
  config_path = "./.kubeconfig"
}

provider "kubectl" {
  config_path = "./.kubeconfig"
}

provider "argocd" {
  server_addr = "localhost:8080"
  username    = "admin"
  password    = "test"
  insecure    = true
  grpc_web    = true
}

provider "github" {
  token = "test"
}