terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.79.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.79.0"
    }
  }

  backend "gcs" {
    bucket = "<YOUT GCS BUCKET THAT STORE TFSTATE FILE>"
    prefix = "gcp"
  }
}
