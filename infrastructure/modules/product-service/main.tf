resource "azurerm_storage_account" "product" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = merge(var.tags, {
    "environment" = var.environment
  })
}

resource "azurerm_cosmosdb_account" "product" {
  name                = var.cosmos_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  tags = merge(var.tags, {
    "environment" = var.environment
  })
}

resource "azurerm_cosmosdb_sql_database" "product" {
  name                = "product-db"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.product.name
}

resource "azurerm_cosmosdb_sql_container" "products" {
  name                  = "products"
  resource_group_name   = var.resource_group_name
  account_name         = azurerm_cosmosdb_account.product.name
  database_name        = azurerm_cosmosdb_sql_database.product.name
  partition_key_paths  = ["/id"]
  partition_key_version = 2
}

output "storage_account_name" {
  value = azurerm_storage_account.product.name
}

output "cosmos_account_endpoint" {
  value = azurerm_cosmosdb_account.product.endpoint
}

output "cosmos_account_primary_key" {
  value     = azurerm_cosmosdb_account.product.primary_key
  sensitive = true
} 