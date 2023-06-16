module "aks" {
  source = "./modules/aks"

  resource_group_name = data.azurerm_resource_group.aks_rg.name
  location = data.azurerm_resource_group.aks_rg.location
}


output "host" {
    sensitive = true
    value = module.aks.host
}
