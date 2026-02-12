variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "service_name" {
  type    = string
  default = "sentinal-api"
}

variable "image" {
  description = "Full Artifact Registry image path (including tag)"
  type        = string
}

variable "cloudrun_sa_email" {
  description = "Cloud Run runtime service account email"
  type        = string
}
