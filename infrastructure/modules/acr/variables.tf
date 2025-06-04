variable "registry_name" {
  description = "The name of the container registry"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where the container registry will be created"
  type        = string
}

variable "sku" {
  description = "The SKU of the container registry"
  type        = string
  default     = "Premium"
}

variable "admin_enabled" {
  description = "Whether admin access is enabled for the container registry"
  type        = bool
  default     = false
}

variable "geo_replications" {
  description = "List of Azure locations where the container registry should be geo-replicated"
  type        = list(object({
    location                = string
    zone_redundancy_enabled = bool
  }))
  default     = []
}

variable "allowed_ip_ranges" {
  description = "List of IP ranges to allow access to the container registry"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "tags" {
  description = "A map of tags to be applied to the resources"
  type        = map(string)
  default     = {}
}

variable "aks_principal_ids" {
  description = "List of AKS cluster principal IDs that need pull access to the registry"
  type        = list(string)
  default     = []
} 