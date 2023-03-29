terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata { name = "argocd" }
}

data "http" "install_yaml" {
  url = "https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
}

data "kubectl_file_documents" "install_yaml" {
  content = data.http.install_yaml.response_body
}

resource "kubectl_manifest" "install" {
  depends_on = [kubernetes_namespace.argocd]

  for_each           = data.kubectl_file_documents.install_yaml.manifests
  yaml_body          = each.value
  override_namespace = "argocd"
}

data "kubernetes_secret" "argocd_admin_secret" {
  depends_on = [kubectl_manifest.install]
  metadata {
    namespace = "argocd"
    name      = "argocd-initial-admin-secret"
  }
}
