variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "australiaeast"
}

variable "storage_account_name" {
  description = "The name of the Azure Storage Account for Azure Functions"
  type        = string
}

variable "cosmos_account_name" {
  description = "The name of the Cosmos DB account"
  type        = string
}