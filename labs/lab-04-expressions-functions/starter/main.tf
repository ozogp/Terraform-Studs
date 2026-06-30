locals {
  environment = lower(var.environment)

  # TODO: build a reusable name prefix with lower, replace and substr.
  # Hint: substr, replace, lower
  name_prefix = ""

  default_tags = {
    course = "terraform-azure"
    lab    = "04-expressions-functions"
  }

  # TODO: merge default_tags, var.extra_tags and env/owner tags.
  # Hint: owner can use coalesce, trimspace
  tags = local.default_tags

  # TODO: convert var.subnets into final subnet configs.
  # Add a generated name and cidr to each subnet using format, merge and cidrsubnet.
  subnet_configs = {}
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.name_prefix}-expr"
  location = var.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${local.name_prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.address_space]

  tags = local.tags
}

resource "azurerm_subnet" "this" {
  # TODO: create one subnet per local.subnet_configs entry.
  for_each = local.subnet_configs

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.cidr]
  service_endpoints    = each.value.service_endpoints
}

resource "azurerm_network_security_group" "this" {
  # TODO: create one NSG per subnet config.
  for_each = local.subnet_configs

  name                = "nsg-${local.name_prefix}-${each.key}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.tags

  dynamic "security_rule" {
    # TODO: generate one nested security_rule block per rule in each subnet config.
    for_each = {}

    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  # TODO: associate each subnet with the NSG that uses the same map key.
  for_each = local.subnet_configs

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}