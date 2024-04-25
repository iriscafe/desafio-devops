resource "kubernetes_ingress_v1" "api_ingress" {

  metadata {
    name      = "app"
    namespace = "ingress-nginx"
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          path_type = "Prefix"
          path      = "/python"
          backend {
            service {
              name = "app"
              port {
                number = 8000
              }
            }
          }
        }
        path {
          path_type = "Prefix"
          path      = "/grafana"
          backend {
            service {
              name = "grafana"
              port {
                number = 3000
              }
            }
          }
        }
        path {
          path_type = "Prefix"
          path      = "/prometheus"
          backend {
            service {
              name = "prometheus"
              port {
                number = 9090
              }
            }
          }
        }
      }
    }
  }
}