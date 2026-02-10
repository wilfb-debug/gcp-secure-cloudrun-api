variable "project_id" {
  type        = string
  description = "GCP project id"
}

variable "region" {
  type        = string
  description = "Default region"
  default     = "europe-west2"
}

variable "artifact_registry_repo" {
  type        = string
  description = "Artifact Registry repo name"
  default     = "sentinal-app"
}

variable "cloudrun_service_account_name" {
  type        = string
  description = "Service account name for Cloud Run runtime"
  default     = "sa-cloudrun-runtime"
}
