# terraform {
#   backend "azurerm" {
#     resource_group_name  = "RG-ADA---CAKE-Team"
#     storage_account_name = "terstorage123"
#     container_name       = "terstatefile"
#     key                  = "terraform.tfstate"
#   }
# }


storage_account_name = "terstorage123"
container_name       = "terstatefile"
key                  = "terraform.tfstate"