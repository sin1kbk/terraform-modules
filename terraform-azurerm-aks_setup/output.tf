output "kube_config_raw" {
  value     = azurerm_kubernetes_cluster.x.kube_config_raw
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.x.kube_config.0.client_certificate
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.x.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "cluster_key" {
  value     = azurerm_kubernetes_cluster.x.kube_config.0.client_key
  sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.x.kube_config.0.host
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.x.node_resource_group
}
