# define the provider block

provider "google" {
  project     = "thermal-micron-396706"
  region      = "us-central1"
  credentials = "/home/gcp_lab_practice_5/thermal-micron-396706-c64eaa3c309e.json"
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.instance.name
}

# See versions at https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#database_version
resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }
  deletion_protection  = "true"
}