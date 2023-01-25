output "argocd_admin_secret" {
  value     = data.kubernetes_secret.argocd_admin_secret.data
  sensitive = true
}
