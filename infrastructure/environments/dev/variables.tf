variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "australiaeast"
}

variable "resource_group_name" {
  description = "The name of the existing resource group"
  type        = string
  default     = "ecommerce-rg"
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "The project name"
  type        = string
  default     = "ecommerce"
} 