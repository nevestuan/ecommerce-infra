resource "azurerm_kubernetes_cluster" "aks" {
  name                = "ecommerce-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "ecommerceaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
}

output "aks_kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0]
  sensitive = true
}
