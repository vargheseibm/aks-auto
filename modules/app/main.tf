


# resource "kubernetes_namespace_v1" "namespace" {
#   metadata {
#     name = "demo-application"
#   }
# }


resource "helm_release" "demo-app" {
  name       = "viadee"
  repository = "https://viadee.github.io/springboot-helm-chart"
  chart      = "springboot-helm-chart"
  version    = "1.1.0"
  #namespace  = kubernetes_namespace_v1.namespace.metadata[0].name
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "autoscaling.enabled" #cannot be enabled because API is autoscaling/v2beta1 but our kubernetes only supports from autoscaling/v2beta2
    value = "false"
  }
}








