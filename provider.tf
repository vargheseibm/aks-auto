terraform {
    required_version = ">= 1.3"
    backend "azurerm" {
    resource_group_name  = "RG-ADA---CAKE-Team"
    storage_account_name = "terstorage123"
    container_name       = "terstatefile"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "a63f65ad-1ea9-4dee-b564-651209d4c5bc"
  client_secret   = var.client_secret
  tenant_id       = "1f2519d6-a33d-4336-abb5-8085bcb587d6"
  subscription_id = "48ee300d-8738-496a-9366-1271ebefc1e6"
}