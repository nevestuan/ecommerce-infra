terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "ecommerce-rg"
    storage_account_name = "tfstateecommerce"
    container_name      = "tfstate"
    key                 = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Using existing resource group
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_log_analytics_workspace" "aks" {
  name                = "ecommerce-dev-aks-logs"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                = "PerGB2018"
  retention_in_days   = 30

  tags = {
    environment = "dev"
    project     = "ecommerce"
  }
}

module "networking" {
  source              = "../../modules/networking"
  vnet_name           = "ecommerce-dev-vnet"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  environment         = "dev"
  
  vnet_address_space = ["10.0.0.0/16"]
  aks_subnet_prefix  = ["10.0.1.0/24"]

  tags = {
    environment = "dev"
    project     = "ecommerce"
  }
}

module "acr" {
  source              = "../../modules/acr"
  registry_name       = "ecommercedev20240319acr"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  environment         = "dev"
  sku                = "Premium"
  admin_enabled      = false

  allowed_ip_ranges = []
  
  tags = {
    environment = "dev"
    project     = "ecommerce"
  }
}

module "aks" {
  source              = "../../modules/aks"
  cluster_name        = "ecommerce-dev-aks"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  dns_prefix          = "ecommercedevaks"
  environment         = "dev"

  kubernetes_version = "1.32.4"

  default_node_count          = 1
  default_node_pool_vm_size   = "Standard_D2_v5"
  default_node_pool_min_count = 1
  default_node_pool_max_count = 3

  subnet_id                   = module.networking.aks_subnet_id
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.aks.id

  tags = {
    environment = "dev"
    project     = "ecommerce"
  }

  depends_on = [module.acr]
}

module "product_service" {
  source              = "../../modules/product-service"
  storage_account_name = "ecommerceproductdev"
  cosmos_account_name  = "ecommerce-product-dev"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  environment         = "dev"

  tags = {
    environment = "dev"
    project     = "ecommerce"
  }
} 