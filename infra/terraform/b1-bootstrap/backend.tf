terraform {
  backend "gcs" {
    bucket = "gcp-secure-cloudrun-api-tfstate-1770757517"
    prefix = "b1-bootstrap/state"
  }
}
