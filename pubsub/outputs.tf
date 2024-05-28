output "pubsub_topic_name" {
  description = "The name of the created Pub/Sub topic"
  value       = google_pubsub_topic.topic.name
}

output "pubsub_dl_topic_names" {
  description = "The names of the created dead letter Pub/Sub topics"
  value       = [for k, v in google_pubsub_topic.dl_topic : v.name]
}

output "pubsub_subscriptions" {
  description = "The names of the created Pub/Sub subscriptions"
  value       = [for k, v in google_pubsub_subscription.pull_subscription : v.name]
}

output "pubsub_dl_subscriptions" {
  description = "The names of the created dead letter Pub/Sub subscriptions"
  value       = [for k, v in google_pubsub_subscription.dl_pull_subscription : v.name]
}
