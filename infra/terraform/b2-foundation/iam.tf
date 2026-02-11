# B2.1 IAM: least-privilege permissions for Cloud Run runtime

# Allow Cloud Run runtime SA to pull container images from Artifact Registry
resource "google_artifact_registry_repository_iam_member" "runtime_sa_can_pull_images" {
  project    = var.project_id
  location   = var.region
  repository = google_artifact_registry_repository.repo.repository_id

  role   = "roles/artifactregistry.reader"
  member = "serviceAccount:${google_service_account.cloudrun_runtime.email}"
}

# Allow Cloud Run runtime SA to write logs
resource "google_project_iam_member" "runtime_sa_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudrun_runtime.email}"
}

# Allow Cloud Run runtime SA to write metrics
resource "google_project_iam_member" "runtime_sa_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.cloudrun_runtime.email}"
}

# (Optional but recommended) Allow trace exporting if you later enable tracing
resource "google_project_iam_member" "runtime_sa_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloudrun_runtime.email}"
}
