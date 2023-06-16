

# Datasource to get Latest Azure AKS latest Version
# data "azurerm_kubernetes_service_versions" "current" {
#   location = data.azurerm_resource_group.aks_rg.location
#   include_preview = false  
# }

# output "version" {
#     value = data.azurerm_kubernetes_service_versions.current
  
# }

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = data.azurerm_resource_group.aks_rg.location
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
    orchestrator_version = "1.25.6"
    enable_auto_scaling  = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb = 30
    type                 = "VirtualMachineScaleSets"
  }
  
  role_based_access_control_enabled = true

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}