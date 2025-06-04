resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "default"
    node_count          = var.default_node_count
    vm_size            = var.default_node_pool_vm_size
    os_disk_size_gb    = var.default_node_pool_disk_size
    vnet_subnet_id     = var.subnet_id

    tags = merge(var.tags, {
      "nodepool-type" = "system"
      "environment"   = var.environment
    })
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy     = "azure"
    load_balancer_sku  = "standard"
    service_cidr       = "172.16.0.0/16"
    dns_service_ip     = "172.16.0.10"
    pod_cidr           = "172.17.0.0/16"
  }

  role_based_access_control_enabled = true

  azure_policy_enabled = true

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  tags = merge(var.tags, {
    "environment" = var.environment
  })
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0]
  sensitive = true
}

output "aks_kubelet_identity" {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0]
} 