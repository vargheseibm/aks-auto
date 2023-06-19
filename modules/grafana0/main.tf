resource "azurerm_resource_group" "azurerm_dashboard_grafana_rg" {
  name     = "azurerm_dashboard_grafana_rg"
  location = var.location

  lifecycle {
    ignore_changes = [tags["expiresOn"]] # NT automatically adds tags to RGs
  }
}


resource "azurerm_monitor_workspace" "azmonitor_gf_wspace" {
  name                = "gf_wspace"
  resource_group_name = var.resource_group_name
  location            = var.location
 
}


resource "azurerm_dashboard_grafana" "azurerm_dashboard_grafana" {
  name                = "defaultgrafana"
  resource_group_name = var.resource_group_name
  location            = var.location
  api_key_enabled     = true
  azure_monitor_workspace_integrations {
    resource_id = azurerm_monitor_workspace.azmonitor_gf_wspace.id
  }

  identity {
    type = "SystemAssigned"
  }

}

output grafana_endpoint {

    value = azurerm_dashboard_grafana.azurerm_dashboard_grafana.endpoint
}

data "azurerm_client_config" "current" {
}

# Provides admin roles for grafana in the subscription to the CAKE team
resource "azurerm_role_assignment" "azurerm_dashboard_grafana_editor" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Grafana Admin"
  principal_id         = "d9301a44-e3a0-4d08-8c87-55cc1dc91c00"
}

# Provides Monitoring Reader role in the subscription to the Grafana Managed Identity
resource "azurerm_role_assignment" "grafana_msi_monitoring_reader" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.azurerm_dashboard_grafana.identity[0].principal_id
}


# ----- Grafana Content -----

resource "grafana_data_source" "azure_monitor" {
  name        = "Custom Azure Monitor"
  type        = "grafana-azure-monitor-datasource"
  access_mode = "proxy"
  is_default  = true
  json_data_encoded = jsonencode({
    azureAuthType  = "msi" # Azure Managed Identity
    subscriptionId = data.azurerm_client_config.current.subscription_id
  })
}



