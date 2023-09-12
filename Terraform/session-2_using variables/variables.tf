# to define the variables
variable "project" {
  description = "GOOGLE CLOUD PROJECT ID"
  type        = string
}

variable "region" {
  description = "Region for the instance"
  type        = string
  default     = "us-central1"
}

variable "credentials" {
  description = "path to service account key json file"
  type        = string
}

variable "instance_name" {
  description = "name of the vm instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the instance"
  type        = string
  default     = "n1-standard-1"
}

variable "zone" {
  description = "Zone for the instance"
  type        = string
}

variable "osimage" {
  description = "Boot disk image"
  type        = string
  default     = "debian-cloud/debian-10"
}