output "client_certificate" {
  value     = azurerm_kubernetes_cluster.x.kube_config.0.client_certificate
  sensitive = true
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.x.fqdn
}

output "kube_config_raw" {
  value     = azurerm_kubernetes_cluster.x.kube_config_raw
  sensitive = true
}
