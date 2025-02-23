resource "random_string" "azurerm_cognitive_account_name" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_cognitive_account" "form_recognizer" {
  name                = "FormRecognizer-${random_string.azurerm_cognitive_account_name.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = var.sku
  kind                = "FormRecognizer"
}

resource "azurerm_cognitive_account" "speech_recognizer" {
  name                = "SpeechRecognizer-${random_string.azurerm_cognitive_account_name.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = var.sku
  kind                = "SpeechServices"
}

resource "azurerm_storage_account" "blob_storage" {
  name                     = "blobstorageitsteppnivchuk"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_role_assignment" "blob_access" {
  scope                = azurerm_storage_account.blob_storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.principal_id
}