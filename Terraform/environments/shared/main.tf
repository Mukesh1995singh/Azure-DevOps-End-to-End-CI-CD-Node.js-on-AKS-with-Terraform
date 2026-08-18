# =========================================================
# Shared Resource Group
# =========================================================

module "resource_group" {
  source = "../../modules/resource-group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}


# =========================================================
# Shared ACR
# =========================================================

module "acr" {
  source = "../../modules/acr"

  acr_name            = var.acr_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  sku                 = var.sku
  tags                = var.tags
}