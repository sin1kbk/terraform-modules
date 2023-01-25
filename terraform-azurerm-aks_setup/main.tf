terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.36.0"
    }
  }
}

## Setup AKS
data "azurerm_resource_group" "x" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "x" {
  name                = "${var.name_prefix}-vnet"
  location            = data.azurerm_resource_group.x.location
  resource_group_name = data.azurerm_resource_group.x.name
  address_space       = [var.subnet]
}

resource "azurerm_subnet" "x" {
  name                 = "${var.name_prefix}-default-subnet"
  virtual_network_name = azurerm_virtual_network.x.name
  resource_group_name  = data.azurerm_resource_group.x.name
  address_prefixes     = [var.subnet]
}

resource "azurerm_kubernetes_cluster" "x" {
  depends_on = [azurerm_subnet.x]

  location            = data.azurerm_resource_group.x.location
  name                = "${var.name_prefix}-cluster"
  resource_group_name = data.azurerm_resource_group.x.name
  dns_prefix          = var.name_prefix

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name            = "default"
    vm_size         = var.vm_size
    os_disk_size_gb = var.os_disk_size_gb
    node_count      = var.node_count
    max_pods        = var.max_pods
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    dns_service_ip     = var.dns_service_ip
    service_cidr       = azurerm_subnet.x.address_prefixes[0]
    docker_bridge_cidr = "172.16.0.1/16"
    load_balancer_sku  = "standard"
    outbound_type      = "loadBalancer"
  }
}
