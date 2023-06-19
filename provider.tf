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

     grafana = {
      source  = "grafana/grafana"
      version = "~>1.40.1"
    }

    external = {
      source  = "hashicorp/external"
      version = "~>2.3.1"
    }

  }


}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "a63f65ad-1ea9-4dee-b564-651209d4c5bc"
  client_secret   = "Qnd8Q~lSFMRgcE642yRRTuxp00S6Hd1Z5Z5jobkA"
  tenant_id       = "1f2519d6-a33d-4336-abb5-8085bcb587d6"
  subscription_id = "48ee300d-8738-496a-9366-1271ebefc1e6"
}


provider "helm" {
  kubernetes {

    host     = module.aks.host

    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}


data "external" "grafana_oauth_token" {
    program = [
    "sh", "-c",
    <<-EOF
    curl -X POST \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "grant_type=client_credentials" \
        -d "client_id=$ARM_CLIENT_ID" \
        -d "client_secret=$ARM_CLIENT_SECRET" \
        -d "resource=ce34e7e5-485f-4d76-964f-b3d2b16d1e4f" \
        "https://login.microsoftonline.com/$ARM_TENANT_ID/oauth2/token"
    EOF
  ]


data "azurerm_client_config" "current" {
}