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

data "local_file" "kubeconfig" {
  filename = "./kubeconfig"
}

provider "kubernetes" {
  config_path = data.local_file.kubeconfig.filename
}

provider "kubectl" {
  config_path = data.local_file.kubeconfig.filename
}