variable "location" {
  description = "location of clusterr"
  default     = "centralus"
}

variable "azure_resource_group_name" {
  description = "Resource Group Name"
  default     = "aks-tf-cluster"
}

variable "name" {
  description = "name of cluster"
  default     = "akstf01"
}

variable "dns_prefix" {
  description = "dns prefix of cluster"
  default     = "aks-tf-cluster"
}

variable "kubernetes_version" {
  description = "Kubernetes Version"
  default     = "1.9.6"
}

variable "node_count" {
  description = "Number of worker nodes in cluster"
  default     = "3"
}

variable "vm_size" {
  description = "Size Of worker Node VM"
  default     = "Standard_DS2_v2"
}
