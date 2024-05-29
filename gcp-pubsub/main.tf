locals {
  pubsub_svc_account_email = "service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
  dl_pull_subscriptions = flatten([
    for sub_key, sub in var.subscriptions : [
      for dl_key, dl in sub.dead_letter_policy.topic.subscriptions : merge(dl, {
        dl_key  = dl_key,
        sub_key = sub_key,
        name    = dl.name != null ? dl.name : (sub.dead_letter_policy.topic.name != "" ? sub.dead_letter_policy.topic.name : "${sub.name != null ? sub.name : sub_key}-dl")
      })
    ] if sub.dead_letter_policy != null
  ])
}

data "google_project" "project" {
  project_id = var.project_id
}

module "services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = ">= 14.0"

  project_id                  = var.project_id
  enable_apis                 = var.enable_apis
  disable_services_on_destroy = false

  activate_apis = [
    "pubsub.googleapis.com",
  ]
}

resource "google_pubsub_schema" "schema" {
  count = var.schema != null ? 1 : 0

  project    = var.project
  name       = var.schema.name != null ? var.schema.name : var.name
  type       = var.schema.type
  definition = var.schema.definition

  depends_on = [
    module.services,
  ]
}

resource "google_pubsub_schema_iam_member" "pull_topic_bindings" {
  for_each = { for k, v in var.subscriptions : k => v if v.dead_letter_policy != null }

  project = var.project
  topic   = each.value.dead_letter_policy.topic.name != "" ? each.value.dead_letter_policy.topic.name : (each.value.name != "" ? each.value.name : "default_value")
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${local.pubsub_svc_account_email}"

  depends_on = [
    google_pubsub_topic.dl_topic,
  ]
}

resource "google_pubsub_subscription_iam_member" "pull_subscription_binding" {
  for_each = { for k, v in var.subscriptions : k => v if v.dead_letter_policy != null }

  project      = var.project
  subscription = each.value.name != null ? each.value.name : each.key
  role         = "roles/pubsub.subscriber"
  member       = "serviceAccount:${local.pubsub_svc_account_email}"

  depends_on = [
    google_pubsub_subscription.pull_subscriptions,
  ]
}

resource "google_pubsub_topic" "topic" {
  project      = var.project_id
  name         = var.name
  labels       = var.topic_labels
  kms_key_name = var.topic_kms_key_name

  dynamic "schema_settings" {
    for_each = var.schema != null ? [var.schema] : []
    content {
      schema   = google_pubsub_schema.schema[0].id
      encoding = var.schema.encoding
    }
  }

  depends_on = [
    google_pubsub_schema.schema,
  ]
}

resource "google_pubsub_topic" "dl_topic" {
  for_each = { for k, v in var.subscriptions : k => v if v.dead_letter_policy != null }

  project = var.project_id
  name    = each.value.dead_letter_policy.topic.name != null ? each.value.dead_letter_policy.topic.name : "${each.value.name != null ? each.value.name : each.key}-dl"
  labels  = each.value.dead_letter_policy.topic.topic_labels
  kms_key_name = var.topic_kms_key_name

  dynamic "message_storage_policy" {
    for_each = length(var.allowed_persistence_regions) > 0 ? [1] : []
    content {
      allowed_persistence_regions = var.allowed_persistence_regions
    }
  }

  dynamic "schema_settings" {
    for_each = var.schema != null ? [var.schema] : []
    content {
      schema   = google_pubsub_schema.schema[0].id
      encoding = var.schema.encoding
    }
  }

  depends_on = [
    google_pubsub_schema.schema,
  ]
}

resource "google_pubsub_subscription" "pull_subscription" {
  for_each = var.subscriptions

  name                         = each.value.name != null ? each.value.name : each.key
  topic                        = var.name
  project                      = var.project_id
  labels                       = var.subscription_labels
  enable_exactly_once_delivery = each.value.enable_exactly_once_delivery
  ack_deadline_seconds         = each.value.ack_deadline_seconds
  message_retention_duration   = each.value.message_retention_duration
  retain_acked_messages        = each.value.retain_acked_messages
  filter                       = each.value.filter
  enable_message_ordering      = each.value.enable_message_ordering

  dynamic "expiration_policy" {
    for_each = each.value.dead_letter_policy != null ? [1] : []
    content {
      ttl = each.value.message_ttl
    }
  }

  dynamic "dead_letter_policy" {
    for_each = each.value.retry_policy.maximum_backoff != null ? [1] : []
    content {
      dead_letter_topic     = "projects/${var.project_id}/topics/${each.value.dead_letter_policy.topic.name != null ? each.value.dead_letter_policy.topic.name : "${each.value.name != null ? each.value.name : each.key}-dl"}"
      max_delivery_attempts = each.value.dead_letter_policy.max_delivery_attempts
    }
  }

  dynamic "retry_policy" {
    for_each = each.value.retry_policy.maximum_backoff != null || each.value.retry_policy.minimum_backoff != null ? [1] : []
    content {
      maximum_backoff = each.value.retry_policy.maximum_backoff
      minimum_backoff = each.value.retry_policy.minimum_backoff
    }
  }

  depends_on = [
    google_pubsub_topic.dl_topic,
    google_pubsub_topic.topic,
  ]
}

resource "google_pubsub_subscription" "dl_pull_subscription" {
  for_each = { for s in local.dl_pull_subscriptions : "${s.sub_key}.${s.dl_key}" => s }

  name                         = each.value.name
  project                      = var.project_id
  labels                       = each.value.labels
  enable_exactly_once_delivery = each.value.enable_exactly_once_delivery
  ack_deadline_seconds         = each.value.ack_deadline_seconds
  message_retention_duration   = each.value.message_retention_duration
  retain_acked_messages        = each.value.retain_acked_messages
  filter                       = each.value.filter
  enable_message_ordering      = each.value.enable_message_ordering

  dynamic "expiration_policy" {
    for_each = each.value.message_ttl != null ? [1] : []
    content {
      ttl = each.value.message_ttl
    }
  }

  dynamic "retry_policy" {
    for_each = each.value.retry_policy.maximum_backoff != null || each.value.retry_policy.minimum_backoff != null ? [1] : []
    content {
      maximum_backoff = each.value.retry_policy.maximum_backoff
      minimum_backoff = each.value.retry_policy.minimum_backoff
    }
  }

  depends_on = [
    google_pubsub_topic.dl_topic,
  ]
}
