variable "prefix" {
  type        = string
  description = "Naming prefix for resources."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group to deploy into."
}

variable "address_space" {
  type        = list(string)
  description = "VNet address space."
}

variable "subnets" {
  type        = map(string)
  description = "Map of subnet name => CIDR."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources."
  default     = {}
}
