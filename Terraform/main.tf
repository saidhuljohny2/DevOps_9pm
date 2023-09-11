# define the provider block

provider "google" {
  project     = "thermal-micron-396706"
  region      = "us-central1"
  credentials = "/home/gcp_lab_practice_5/thermal-micron-396706-c64eaa3c309e.json"
}

# define the resource block (create vm in GCP)

resource "google_compute_instance" "default" {
  name         = "test-terraform-code"
  machine_type = "n1-standard-1"
  zone         = "us-central1-c"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "terraform-user@thermal-micron-396706.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}

