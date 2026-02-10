output "cloudrun_runtime_sa_email" {
  value = google_service_account.cloudrun_runtime.email
}

output "artifact_registry_repo" {
  value = google_artifact_registry_repository.repo.name
}
