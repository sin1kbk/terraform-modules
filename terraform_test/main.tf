terraform {
  backend "local" { path = "./terraform.tfstate" }
  required_version = ">= 1.2.0"
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

module "argocd_install" {
  source          = "../argocd/install"
  kubeconfig_path = "./.kubeconfig"
}

module "argocd_setup_application" {
  source         = "../argocd/setup_application"
  admin_password = module.argocd_install.argocd_admin_secret.password
  github_token   = var.GITHUB_TOKEN
  github_owner   = "kubokkey"
}

output "argocd_admin_password" {
  value     = module.argocd_install.argocd_admin_secret.password
  sensitive = true
}

#module "quorum_aks_setup" {
#  source = "../quorum_aks_setup"
#}
