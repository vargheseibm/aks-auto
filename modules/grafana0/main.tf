resource "grafana_folder" "ElasticSearch" {
   provider = grafana.cloud

   title = "ElasticSearch"
}

resource "grafana_folder" "InfluxDB" {
   provider = grafana.cloud

   title = "InfluxDB"
}