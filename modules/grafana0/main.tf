resource "azapi_resource" "azgrafana" {
  type        = "Microsoft.Dashboard/grafana@2022-08-01" 
  name        = "mgf-example"
  parent_id   = var.id
  location    = var.location

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