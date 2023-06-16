module "aks" {
  source = "./modules/aks"

  resource_group_name = data.azurerm_resource_group.aks_rg.name
  location = data.azurerm_resource_group.aks_rg.location
}





# Datasource to get Latest Azure AKS latest Version
# data "azurerm_kubernetes_service_versions" "current" {
#   location = data.azurerm_resource_group.aks_rg.location
#   include_preview = false  
# }

# output "version" {
#     value = data.azurerm_kubernetes_service_versions.current
  
# }