variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "The location where the AKS cluster will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
}

variable "default_node_count" {
  description = "The initial number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "default_node_pool_vm_size" {
  description = "The VM size for the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "default_node_pool_min_count" {
  description = "Minimum number of nodes in the default node pool when auto-scaling is enabled"
  type        = number
  default     = 1
}

variable "default_node_pool_max_count" {
  description = "Maximum number of nodes in the default node pool when auto-scaling is enabled"
  type        = number
  default     = 3
}

variable "default_node_pool_disk_size" {
  description = "The OS disk size in GB for the default node pool"
  type        = number
  default     = 50
}

variable "subnet_id" {
  description = "The ID of the subnet where the AKS cluster will be deployed"
  type        = string
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

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace for container insights"
  type        = string
} 