output "cosmos_endpoint" {
  value = azurerm_cosmosdb_account.product.endpoint
}

output "cosmos_key" {
  value     = azurerm_cosmosdb_account.product.primary_key
  sensitive = true
}