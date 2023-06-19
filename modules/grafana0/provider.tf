terraform {
required_providers {

    grafana = {
      source  = "grafana/grafana"
      version = "~>1.40.1"
    }




}

}


provider "external" {
}

data "external" "grafana_oauth_token" {
    program = [
    "sh", "-c",
    <<-EOF
    curl -X POST \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "grant_type=client_credentials" \
        -d "client_id=$ARM_CLIENT_ID" \
        -d "client_secret=$ARM_CLIENT_SECRET" \
        -d "resource=ce34e7e5-485f-4d76-964f-b3d2b16d1e4f" \
        "https://login.microsoftonline.com/$ARM_TENANT_ID/oauth2/token"
    EOF
  ]
}

data "azurerm_client_config" "current" {
}


provider "grafana" {
  alias = "cloud"
  # connect to managed grafana instance created by azurerm
  #url = azurerm_dashboard_grafana.azurerm_dashboard_grafana.endpoint
  url = azurerm_dashboard_grafana.azurerm_dashboard_grafana.endpoint
  # using Azure SP OAuth access token as Bearer token, not a native Grafana API key
  auth = data.external.grafana_oauth_token.result.access_token
}