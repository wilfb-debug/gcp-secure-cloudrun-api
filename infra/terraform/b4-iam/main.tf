resource "google_cloud_run_v2_service_iam_member" "invoker" {
  project  = var.project_id
  location = var.region
  name     = var.service_name

  role   = "roles/run.invoker"
  member = "serviceAccount:${var.invoker_sa_email}"
}
