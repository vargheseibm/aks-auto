module "aks" {
  source = "./modules/aks"

  resource_group_name = data.azurerm_resource_group.aks_rg.name
  location = data.azurerm_resource_group.aks_rg.location
}


module "app-deploy" {
  depends_on = [ module.aks ]
  source = "./modules/app"
}


module "grafana0" {
  source = "./modules/grafana0"

  resource_group_name = data.azurerm_resource_group.aks_rg.name
  location = data.azurerm_resource_group.aks_rg.location

  id =  data.azurerm_resource_group.aks_rg.id
}


# Datasource to get Latest Azure AKS latest Version
# data "azurerm_kubernetes_service_versions" "current" {
#   location = data.azurerm_resource_group.aks_rg.location
#   include_preview = false  
# }

# output "version" {
#     value = data.azurerm_kubernetes_service_versions.current
  
# }


