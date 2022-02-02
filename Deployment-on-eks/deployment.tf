
resource "kubernetes_deployment" "todo-app" {
  metadata {
    name = "todo-app"
    labels = {
      app = "todo-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "todo-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "todo-app"
        }
      }

      spec {
        container {
          image = "bajpayinaman/todo-app:latest"
          name  = "todo-app"
          port {
            container_port= 5000
          }
          }
        }
      }
    }
  }

resource "kubernetes_service" "todo-app-service" {
  metadata {
    name = "todo-app-service"
  }
  spec {
    selector = {
      app = "todo-app"
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}