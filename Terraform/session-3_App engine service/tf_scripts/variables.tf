variable "custom_service_account_id" {
  description = "Account ID for the custom service account"
  type        = string
}

variable "custom_service_account_display_name" {
  description = "Display name for the custom service account"
  type        = string
}

variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "compute_network_user_role" {
  description = "Role for the custom service account on the project"
  type        = string
}

variable "storage_object_viewer_role" {
  description = "Role for the custom service account for storage"
  type        = string
}

variable "app_version_v1" {
  description = "Version ID for App Engine v1"
  type        = string
}

variable "app_service_name" {
  description = "Name of the App Engine service"
  type        = string
}

variable "app_runtime" {
  description = "Runtime for the App Engine application"
  type        = string
}

variable "app_entrypoint" {
  description = "Entrypoint command for the App Engine application"
  type        = string
}

variable "app_zip_source_url" {
  description = "Source URL for the deployment ZIP file"
  type        = string
}

variable "app_port" {
  description = "Port for the App Engine application"
  type        = string
}

variable "app_max_concurrent_requests" {
  description = "Max concurrent requests for the App Engine application"
  type        = number
}

variable "app_min_idle_instances" {
  description = "Min idle instances for the App Engine application"
  type        = number
}

variable "app_max_idle_instances" {
  description = "Max idle instances for the App Engine application"
  type        = number
}

variable "app_min_pending_latency" {
  description = "Min pending latency for the App Engine application"
  type        = string
}

variable "app_max_pending_latency" {
  description = "Max pending latency for the App Engine application"
  type        = string
}

variable "app_target_cpu_utilization" {
  description = "Target CPU utilization for the App Engine application"
  type        = number
}

variable "app_target_throughput_utilization" {
  description = "Target throughput utilization for the App Engine application"
  type        = number
}

variable "app_min_instances" {
  description = "Min instances for the App Engine application"
  type        = number
}

variable "app_max_instances" {
  description = "Max instances for the App Engine application"
  type        = number
}

