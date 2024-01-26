terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Configure the GCP Provider
provider "google" {
  project = "my-devops-batch06-b"
  region  = "us-central1"
}
