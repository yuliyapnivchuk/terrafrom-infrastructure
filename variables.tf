variable "subscription_id" {
  description = "Azure subscription id"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "sku" {
  type        = string
  description = "The sku name of the Azure Analysis Services server to create. Choose from: B1, B2, D1, S0, S1, S2, S3, S4, S8, S9. Some skus are region specific."
}

variable "sku_name" {
  type        = string
  description = "The SKU name. Possible values are Basic, Standard and Premium."
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "principal_id" {
  type        = string
  description = "The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to."
}

variable "existing_key_vault_name" {
  description = "The name of the existing Azure Key Vault"
  type        = string
}

variable "existing_key_vault_rg" {
  description = "The resource group of the existing Azure Key Vault"
  type        = string
}