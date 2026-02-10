variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "Default region"
  type        = string
  default     = "europe-west2"
}

variable "tf_state_bucket_name" {
  description = "Name of the GCS bucket that stores Terraform remote state"
  type        = string
}
