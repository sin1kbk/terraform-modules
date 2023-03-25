terraform {
  backend "local" { path = "./terraform.tfstate" }
  required_version = ">= 1.2.0"
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

variable "GITHUB_TOKEN" {
  type = string
}

#module "setup_kind" {
#  source = "../kubernetes/setup-kind"
#}

#module "setup_minikube" {
#  source = "../kubernetes/setup-minikube"
#}
#module "setup_kind" {
#  source         = "../kubernetes/setup_kind"
#}

#module "argocd_install" {
#  source          = "../terraform-argocd-install"
#  kubeconfig_path = "./.kubeconfig"
#}

module "argocd_setup_application" {
  source         = "../terraform-argocd-setup_application"
  admin_password = module.argocd_install.argocd_admin_secret.password
  github_token   = var.GITHUB_TOKEN
  github_owner   = "kubokkey"
}

#output "argocd_admin_password" {
#  value     = module.argocd_install.argocd_admin_secret.password
#  sensitive = true
#}

#module "quorum_aks_setup" {
#  source = "../quorum_aks_setup"
#}
