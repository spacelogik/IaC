variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "enable_apis" {
  description = "List of APIs to enable for the project"
  type        = list(string)
}

variable "schema" {
  description = "The Pub/Sub schema configuration"
  type = object({
    name       = optional(string)
    type       = string
    definition = string
    encoding   = optional(string)
  })
  default = null
}

variable "name" {
  description = "The name of the Pub/Sub topic"
  type        = string
}

variable "topic_labels" {
  description = "Labels for the Pub/Sub topic"
  type        = map(string)
  default     = {}
}

variable "topic_kms_key_name" {
  description = "The KMS key name for the Pub/Sub topic"
  type        = string
  default     = ""
}

variable "subscription_labels" {
  description = "Labels for the Pub/Sub subscriptions"
  type        = map(string)
  default     = {}
}

variable "subscriptions" {
  description = "Map of subscription configurations"
  type = map(object({
    name                        = optional(string)
    enable_exactly_once_delivery = bool
    ack_deadline_seconds        = number
    message_retention_duration  = string
    retain_acked_messages       = bool
    filter                      = string
    enable_message_ordering     = bool
    message_ttl                 = optional(string)
    dead_letter_policy = optional(object({
      topic = object({
        name          = string
        topic_labels  = map(string)
        subscriptions = map(object({
          name                        = optional(string)
          enable_exactly_once_delivery = bool
          ack_deadline_seconds        = number
          message_retention_duration  = string
          retain_acked_messages       = bool
          filter                      = string
          enable_message_ordering     = bool
          message_ttl                 = optional(string)
          max_delivery_attempts       = number
        }))
      })
      max_delivery_attempts = number
    }))
    retry_policy = optional(object({
      maximum_backoff = string
      minimum_backoff = string
    }))
  }))
}

variable "allowed_persistence_regions" {
  description = "Allowed persistence regions for the Pub/Sub topic"
  type        = list(string)
  default     = []
}

variable "docker_logsink_filter" {
  description = "Filter for Docker log sink"
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels for the GCP project"
  type        = map(string)
  default     = {}
}

variable "default_exclusions_filter" {
  description = "Default exclusions filter for logging"
  type        = map(string)
  default     = {}
}

variable "bucket_project" {
  description = "The project to create the bucket in"
  type        = string
  default     = null
}

variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
  default     = null
}

variable "bucket_location" {
  description = "The location of the bucket"
  type        = string
  default     = null
}

variable "bucket_versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "bucket_force_destroy" {
  description = "Force destroy the bucket"
  type        = bool
  default     = false
}

variable "bucket_ula" {
  description = "The user-managed logs bucket"
  type        = string
  default     = null
}

variable "lien" {
  description = "Enable lien on the project"
  type        = bool
  default     = false
}

variable "auto_create_network" {
  description = "Auto-create network for the project"
  type        = bool
  default     = false
}

variable "svpc_host_project_id" {
  description = "Shared VPC host project ID"
  type        = string
  default     = null
}

variable "shared_vpc_subnets" {
  description = "Subnets for shared VPC"
  type        = list(string)
  default     = []
}

variable "enable_shared_vpc_host_project" {
  description = "Enable shared VPC host project"
  type        = bool
  default     = false
}

variable "vpc_service_control_attach_enabled" {
  description = "Enable VPC service control attachment"
  type        = bool
  default     = false
}

variable "vpc_service_control_perimeter_name" {
  description = "Name of the VPC service control perimeter"
  type        = string
  default     = null
}

variable "usage_bucket_name" {
  description = "Name of the usage bucket"
  type        = string
  default     = null
}

variable "usage_bucket_prefix" {
  description = "Prefix for the usage bucket"
  type        = string
  default     = null
}

variable "domain" {
  description = "Domain name for the project"
  type        = string
  default     = null
}

variable "group_name" {
  description = "Group name for the project"
  type        = string
  default     = null
}

variable "group_role" {
  description = "Group role for the project"
  type        = string
  default     = null
}

variable "budget_amount" {
  description = "Budget amount for the project"
  type        = number
  default     = null
}

variable "budget_display_name" {
  description = "Display name for the budget"
  type        = string
  default     = null
}

variable "budget_alert_pubsub_topic" {
  description = "Pub/Sub topic for budget alerts"
  type        = string
  default     = null
}

variable "budget_monitoring_notification_channels" {
  description = "Monitoring notification channels for budget alerts"
  type        = list(string)
  default     = []
}

variable "budget_alert_spent_percents" {
  description = "Spent percentages for budget alerts"
  type        = list(number)
  default     = []
}

variable "grant_services_security_admin_role" {
  description = "Grant services security admin role"
  type        = bool
  default     = false
}

variable "consumer_quotas" {
  description = "Consumer quotas for the project"
  type        = map(any)
  default     = {}
}
