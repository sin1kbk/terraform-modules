data "kubernetes_secret" "argocd_admin_secret" {
  depends_on = [kubectl_manifest.install]
  metadata {
    namespace = "argocd"
    name      = "argocd-initial-admin-secret"
  }
}

output "argocd_admin_secret" {
  value     = data.kubernetes_secret.argocd_admin_secret.data
  sensitive = true
}
