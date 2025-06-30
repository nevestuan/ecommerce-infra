variable "location" {
  description = "Azure region for shared resources"
  type        = string
  default     = "australiaeast"
}

variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
  default     = "ecommerce-rg"
}
