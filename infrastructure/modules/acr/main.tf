resource "azurerm_container_registry" "acr" {
  name                = var.registry_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                = var.sku
  admin_enabled      = var.admin_enabled

  tags = merge(var.tags, {
    "environment" = var.environment
  })
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  count                = length(var.aks_principal_ids)
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = var.aks_principal_ids[count.index]
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  value     = var.admin_enabled ? azurerm_container_registry.acr.admin_username : null
  sensitive = true
}

output "acr_admin_password" {
  value     = var.admin_enabled ? azurerm_container_registry.acr.admin_password : null
  sensitive = true
} 