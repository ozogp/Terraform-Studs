locals {
  env = "dev"

  # TODO: build a storage account name: lowercase, no dashes, <= 24 chars
  # hint: use replace and lower

  # TODO: merge default tags with an env tag
  tags = {
    course = "terraform-azure"
    owner  = var.owner
    # env = ...
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${var.prefix}-${local.env}"
  location = var.location
  tags     = local.tags
}

# TODO: create an azurerm_storage_account named local.storage_account_name
# - account_tier = "Standard", account_replication_type = "LRS"
# - min_tls_version = "TLS1_2"
# - tags = local.tags
