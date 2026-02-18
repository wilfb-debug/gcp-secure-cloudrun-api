resource "google_cloud_run_v2_service" "api" {
  name     = var.service_name
  location = var.region

  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = var.cloudrun_sa_email

    containers {
      image = var.image

      ports {
        container_port = 8080
      }

    }
  }
}
