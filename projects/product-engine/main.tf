terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.90"
    }
  }

  backend "azurerm" {
    resource_group_name  = "ecommerce-rg"
    storage_account_name = "tfstateecommerce"
    container_name       = "tfstate"
    key                  = "product-engine.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "product" {
  name     = "ecommerce-rg"
  location = var.location
}

resource "azurerm_storage_account" "product" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.product.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_cosmosdb_account" "product" {
  name                = var.cosmos_account_name
  location            = var.location
  resource_group_name = azurerm_resource_group.product.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "product" {
  name                = "product-db"
  resource_group_name = azurerm_resource_group.product.name
  account_name        = azurerm_cosmosdb_account.product.name
}

resource "azurerm_cosmosdb_sql_container" "products" {
  name                = "products"
  resource_group_name = azurerm_resource_group.product.name
  account_name        = azurerm_cosmosdb_account.product.name
  database_name       = azurerm_cosmosdb_sql_database.product.name
  partition_key_paths = ["/id"]
  partition_key_version = 2
}