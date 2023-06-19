module "aks" {
  source = "./modules/aks"

  resource_group_name = data.azurerm_resource_group.aks_rg.name
  location = data.azurerm_resource_group.aks_rg.location
}


module "app-deploy" {
  depends_on = [ module.aks ]
  source = "./modules/app"
}


# module "grafana0" {
#   source = "./modules/grafana0"

#   resource_group_name = data.azurerm_resource_group.aks_rg.name
#   location = data.azurerm_resource_group.aks_rg.location
# }


# Datasource to get Latest Azure AKS latest Version
# data "azurerm_kubernetes_service_versions" "current" {
#   location = data.azurerm_resource_group.aks_rg.location
#   include_preview = false  
# }

# output "version" {
#     value = data.azurerm_kubernetes_service_versions.current
  
# }

resource "azapi_resource" "azgrafana" {
  type        = "Microsoft.Dashboard/grafana@2022-08-01" 
  name        = "mgf-example"
  parent_id   = data.azurerm_resource_group.aks_rg.id
  location    = data.azurerm_resource_group.aks_rg.location

  identity {
    type      = "SystemAssigned"
  }

  body = jsonencode({
    sku = {
      name = "Standard"
    }
    properties = {
      publicNetworkAccess = "Enabled",
      zoneRedundancy = "Enabled",
      apiKey = "Enabled",
      deterministicOutboundIP = "Enabled"
    }
  })

}
