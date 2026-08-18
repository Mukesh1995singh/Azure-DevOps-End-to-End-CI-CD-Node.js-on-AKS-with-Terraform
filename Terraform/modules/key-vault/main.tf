# ============================================================
# Azure Key Vault
# ============================================================

resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  rbac_authorization_enabled = true

  tags = var.tags
}


# ============================================================
# Terraform Service Principal - Key Vault Secret Permission
# ============================================================

resource "azurerm_role_assignment" "terraform_key_vault_secrets_officer" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.terraform_principal_object_id
}


# ============================================================
# MongoDB Connection Secrets
# ============================================================

resource "azurerm_key_vault_secret" "db_host" {
  name         = "db-host"
  value        = var.db_host
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [
    azurerm_role_assignment.terraform_key_vault_secrets_officer
  ]
}

resource "azurerm_key_vault_secret" "db_name" {
  name         = "db-name"
  value        = var.db_name
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [
    azurerm_role_assignment.terraform_key_vault_secrets_officer
  ]
}

resource "azurerm_key_vault_secret" "db_username" {
  name         = "db-username"
  value        = var.db_username
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [
    azurerm_role_assignment.terraform_key_vault_secrets_officer
  ]
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  value        = var.db_password
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [
    azurerm_role_assignment.terraform_key_vault_secrets_officer
  ]
}

resource "azurerm_key_vault_secret" "mongodb_root_username" {
  name         = "mongodb-root-username"
  value        = var.mongodb_root_username
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [
    azurerm_role_assignment.terraform_key_vault_secrets_officer
  ]
}

resource "azurerm_key_vault_secret" "mongodb_root_password" {
  name         = "mongodb-root-password"
  value        = var.mongodb_root_password
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [
    azurerm_role_assignment.terraform_key_vault_secrets_officer
  ]
}