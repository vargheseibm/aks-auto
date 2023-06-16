module "aks" {
  source = "./modules/aks"

  resource_group_name = data.azurerm_resource_group.aks_rg.name
  location = data.azurerm_resource_group.aks_rg.location
}


output "host" {
    value = module.aks.azurerm_kubernetes_cluster.k8s.host
}
