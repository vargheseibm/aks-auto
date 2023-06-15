data "azurerm_resource_group" "aks_rg" {
  name   = var.resource_group_name   
 
}

output "name" {
    value = data.azurerm_resource_group.aks_rg.name
  
}