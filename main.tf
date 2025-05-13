resource "random_string" "azurerm_name" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_cognitive_account" "form_recognizer" {
  name                = "FormRecognizer-${random_string.azurerm_name.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = var.sku
  kind                = "FormRecognizer"
}

resource "azurerm_storage_account" "blob_storage" {
  name                     = "blobstorage${random_string.azurerm_name.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.sku_name
  account_replication_type = "LRS"
}

resource "azurerm_container_registry" "container_registry" {
  name                = "itstep"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.sku_name
  admin_enabled       = true
}

data "azurerm_key_vault" "existing" {
  name                = var.existing_key_vault_name
  resource_group_name = var.existing_key_vault_rg
}

resource "azurerm_key_vault_secret" "form_recognizer_key" {
  name         = "DOC-INTELLIGENCE-KEY"
  value        = azurerm_cognitive_account.form_recognizer.primary_access_key
  key_vault_id = data.azurerm_key_vault.existing.id
}

resource "azurerm_key_vault_secret" "form_recognizer_endpoint" {
  name         = "DOC-INTELLIGENCE-ENDPOINT"
  value        = azurerm_cognitive_account.form_recognizer.endpoint
  key_vault_id = data.azurerm_key_vault.existing.id
}

resource "azurerm_key_vault_secret" "blob_storage_key" {
  name         = "BLOB-STORAGE-KEY"
  value        = azurerm_storage_account.blob_storage.primary_access_key
  key_vault_id = data.azurerm_key_vault.existing.id
}

resource "azurerm_key_vault_secret" "storage_account_name" {
  name         = "BLOB-STORAGE-ACCOUNT-NAME"
  value        = azurerm_storage_account.blob_storage.name
  key_vault_id = data.azurerm_key_vault.existing.id
}

resource "azurerm_key_vault_secret" "container_registry_username" {
  name         = "REGISTRY-USERNAME"
  value        = azurerm_container_registry.container_registry.admin_username
  key_vault_id = data.azurerm_key_vault.existing.id
}

resource "azurerm_key_vault_secret" "container_registry_password" {
  name         = "REGISTRY-PASSWORD"
  value        = azurerm_container_registry.container_registry.admin_password
  key_vault_id = data.azurerm_key_vault.existing.id
}