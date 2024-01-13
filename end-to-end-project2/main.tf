resource "google_compute_instance" "web-1" {
  name         = "jenkins-master-vm"
  machine_type = "n1-standard-2"
  zone         = "us-west4-b"  # Change to your desired zone

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240109"
      size  = 10
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"  

    access_config {
      // Allocate a public IP to the instance
    }
  }

  metadata_startup_script = file("master_install.sh")

  tags = ["jenkins-master"]
}

resource "google_compute_instance" "web-2" {
  name         = "jenkins-slave-vm"
  machine_type = "n1-standard-2"
  zone         = "us-west4-b"  # Change to your desired zone

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240109"
      size  = 10
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"  

    access_config {
      // Allocate a public IP to the instance
    }
  }

  metadata_startup_script = file("slave_install.sh")

  tags = ["jenkins-master"]
}

resource "google_compute_firewall" "firewall_1" {
  name    = "jenkins-vm-gke"
  network = "default"  

  allow {
    protocol = "tcp"
    ports    = [22, 80, 443, 8080, 9000, 3000, 42779]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["jenkins-master"]
}

resource "google_service_account" "default" {
  account_id   = "gke-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}