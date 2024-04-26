terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

    }
  }

  backend "azurerm" {
    backendAzureRmResourceGroupName  = var.resource_group
    backendAzureRmStorageAccountName = var.storageAccountName
    backendAzureRmContainerName       = var.storageAccountName
    backendAzureRmKey    = "terraform.tfstate"
    subscription_id      = var.subscription_id
    tenant_id            = var.tenant_id
    client_id            = var.client_id
    client_secret        = var.client_secret
  }

}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
      # purge_soft_deleted_certificates_on_destroy = true
      # recover_soft_deleted_certificates          = true
    }
  }
}
