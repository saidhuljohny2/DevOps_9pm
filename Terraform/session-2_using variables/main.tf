# define the provider block

provider "google" {
  project     = var.project
  region      = var.region
  credentials = var.credentials
}

# define the resource block (create vm in GCP)

resource "google_compute_instance" "myvm" {
  count        = 3
  name         = "${var.instance_name}-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone


  boot_disk {
    initialize_params {
      image = var.osimage
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

  }
}