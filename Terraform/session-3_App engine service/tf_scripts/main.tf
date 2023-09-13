# define the provider block

provider "google" {
  project     = var.project_id
  region      = var.region
}

resource "google_service_account" "custom_service_account" {
  account_id   = var.custom_service_account_id
  display_name = var.custom_service_account_display_name
  project      = var.project_id # Add this line to specify the project
}


resource "google_project_iam_member" "gae_api" {
  project = var.project_id
  role    = var.compute_network_user_role
  member  = "serviceAccount:${google_service_account.custom_service_account.email}"
}

resource "google_project_iam_member" "storage_viewer" {
  project = var.project_id
  role    = var.storage_object_viewer_role
  member  = "serviceAccount:${google_service_account.custom_service_account.email}"
}

resource "google_app_engine_standard_app_version" "myapp_v1" {
  project    = var.project_id
  version_id = var.app_version_v1
  service    = var.app_service_name
  runtime    = var.app_runtime

  entrypoint {
    shell = var.app_entrypoint
  }

  deployment {
    zip {
      source_url = var.app_zip_source_url
    }
  }

  env_variables = {
    port = var.app_port
  }

  automatic_scaling {
    max_concurrent_requests = var.app_max_concurrent_requests
    min_idle_instances      = var.app_min_idle_instances
    max_idle_instances      = var.app_max_idle_instances
    min_pending_latency     = var.app_min_pending_latency
    max_pending_latency     = var.app_max_pending_latency

    standard_scheduler_settings {
      target_cpu_utilization        = var.app_target_cpu_utilization
      target_throughput_utilization = var.app_target_throughput_utilization
      min_instances                 = var.app_min_instances
      max_instances                 = var.app_max_instances
    }
  }

  delete_service_on_destroy = true
  service_account           = google_service_account.custom_service_account.email
}

