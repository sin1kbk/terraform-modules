terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "kubectl" {
  config_path = var.kubeconfig_path
}
