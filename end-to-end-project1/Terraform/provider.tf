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
  project = "rock-cairn-410706"
  region  = "us-central1"
}
