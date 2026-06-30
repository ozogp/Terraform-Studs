terraform {
  required_version = ">= 1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "prefix" {
  type    = string
  default = "tfcourse-ab"
}

variable "location" {
  type    = string
  default = "polandcentral"
}

variable "address_space" {
  type    = list(string)
  default = ["10.40.0.0/16"]
}

variable "subnets" {
  type = map(object({
    cidr = string
  }))
  default = {
    web = { cidr = "10.40.1.0/24" }
    db  = { cidr = "10.40.2.0/24" }
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${var.prefix}-net"
  location = var.location
}

# TODO: create azurerm_virtual_network "this" using var.address_space

# TODO: create azurerm_subnet "this" with for_each = var.subnets
#   name                 = "snet-${each.key}"
#   address_prefixes     = [each.value.cidr]

# TODO: output a map of subnet name => id
