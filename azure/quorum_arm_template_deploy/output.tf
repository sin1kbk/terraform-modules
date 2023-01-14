output "kubeconfig_raw" {
  value = data.azurerm_kubernetes_cluster.x.kube_config_raw
}

output "fqdn" {
  value = data.azurerm_kubernetes_cluster.x.fqdn
}

output "template_output" {
  value = azurerm_resource_group_template_deployment.quorum.output_content
}
