# define the provider block

provider "google" {
  project     = "thermal-micron-396706"
  region      = "us-central1"
  credentials = "/home/gcp_lab_practice_5/thermal-micron-396706-c64eaa3c309e.json"
}

#create resource

resource "google_compute_instance_template" "tpl" {
  name         = "template"
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    disk_size_gb = 100
    boot         = true
  }

  network_interface {
    network = "default"
  }

  metadata = {
    foo = "bar"
  }

  can_ip_forward = true
}

resource "google_compute_instance_from_template" "tpl" {
  name = "instance-from-template"
  zone = "us-central1-a"

  source_instance_template = google_compute_instance_template.tpl.self_link_unique

  // Override fields from instance template
  can_ip_forward = false
  labels = {
    my_key = "my_value"
  }
}