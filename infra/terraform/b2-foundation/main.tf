resource "google_service_account" "cloudrun_runtime" {
  account_id   = var.cloudrun_service_account_name
  display_name = "Cloud Run runtime service account"
}

resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = var.artifact_registry_repo
  description   = "Container images for Sentinal"
  format        = "DOCKER"
}
