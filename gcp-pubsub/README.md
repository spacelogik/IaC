<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.50.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.50.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_services"></a> [services](#module\_services) | terraform-google-modules/project-factory/google//modules/project_services | >= 14.0 |

## Resources

| Name | Type |
|------|------|
| [google_pubsub_schema.schema](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_schema) | resource |
| [google_pubsub_schema_iam_member.pull_topic_bindings](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_schema_iam_member) | resource |
| [google_pubsub_subscription.dl_pull_subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription.pull_subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription_iam_member.pull_subscription_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_member) | resource |
| [google_pubsub_topic.dl_topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic.topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_persistence_regions"></a> [allowed\_persistence\_regions](#input\_allowed\_persistence\_regions) | Allowed persistence regions for the Pub/Sub topic | `list(string)` | `[]` | no |
| <a name="input_auto_create_network"></a> [auto\_create\_network](#input\_auto\_create\_network) | Auto-create network for the project | `bool` | `false` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | Force destroy the bucket | `bool` | `false` | no |
| <a name="input_bucket_location"></a> [bucket\_location](#input\_bucket\_location) | The location of the bucket | `string` | `null` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket | `string` | `null` | no |
| <a name="input_bucket_project"></a> [bucket\_project](#input\_bucket\_project) | The project to create the bucket in | `string` | `null` | no |
| <a name="input_bucket_ula"></a> [bucket\_ula](#input\_bucket\_ula) | The user-managed logs bucket | `string` | `null` | no |
| <a name="input_bucket_versioning"></a> [bucket\_versioning](#input\_bucket\_versioning) | Enable versioning for the bucket | `bool` | `false` | no |
| <a name="input_budget_alert_pubsub_topic"></a> [budget\_alert\_pubsub\_topic](#input\_budget\_alert\_pubsub\_topic) | Pub/Sub topic for budget alerts | `string` | `null` | no |
| <a name="input_budget_alert_spent_percents"></a> [budget\_alert\_spent\_percents](#input\_budget\_alert\_spent\_percents) | Spent percentages for budget alerts | `list(number)` | `[]` | no |
| <a name="input_budget_amount"></a> [budget\_amount](#input\_budget\_amount) | Budget amount for the project | `number` | `null` | no |
| <a name="input_budget_display_name"></a> [budget\_display\_name](#input\_budget\_display\_name) | Display name for the budget | `string` | `null` | no |
| <a name="input_budget_monitoring_notification_channels"></a> [budget\_monitoring\_notification\_channels](#input\_budget\_monitoring\_notification\_channels) | Monitoring notification channels for budget alerts | `list(string)` | `[]` | no |
| <a name="input_consumer_quotas"></a> [consumer\_quotas](#input\_consumer\_quotas) | Consumer quotas for the project | `map(any)` | `{}` | no |
| <a name="input_default_exclusions_filter"></a> [default\_exclusions\_filter](#input\_default\_exclusions\_filter) | Default exclusions filter for logging | `map(string)` | `{}` | no |
| <a name="input_docker_logsink_filter"></a> [docker\_logsink\_filter](#input\_docker\_logsink\_filter) | Filter for Docker log sink | `string` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domain name for the project | `string` | `null` | no |
| <a name="input_enable_apis"></a> [enable\_apis](#input\_enable\_apis) | List of APIs to enable for the project | `list(string)` | n/a | yes |
| <a name="input_enable_shared_vpc_host_project"></a> [enable\_shared\_vpc\_host\_project](#input\_enable\_shared\_vpc\_host\_project) | Enable shared VPC host project | `bool` | `false` | no |
| <a name="input_grant_services_security_admin_role"></a> [grant\_services\_security\_admin\_role](#input\_grant\_services\_security\_admin\_role) | Grant services security admin role | `bool` | `false` | no |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | Group name for the project | `string` | `null` | no |
| <a name="input_group_role"></a> [group\_role](#input\_group\_role) | Group role for the project | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels for the GCP project | `map(string)` | `{}` | no |
| <a name="input_lien"></a> [lien](#input\_lien) | Enable lien on the project | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Pub/Sub topic | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the GCP project | `string` | n/a | yes |
| <a name="input_schema"></a> [schema](#input\_schema) | The Pub/Sub schema configuration | <pre>object({<br>    name       = optional(string)<br>    type       = string<br>    definition = string<br>    encoding   = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_shared_vpc_subnets"></a> [shared\_vpc\_subnets](#input\_shared\_vpc\_subnets) | Subnets for shared VPC | `list(string)` | `[]` | no |
| <a name="input_subscription_labels"></a> [subscription\_labels](#input\_subscription\_labels) | Labels for the Pub/Sub subscriptions | `map(string)` | `{}` | no |
| <a name="input_subscriptions"></a> [subscriptions](#input\_subscriptions) | Map of subscription configurations | <pre>map(object({<br>    name                        = optional(string)<br>    enable_exactly_once_delivery = bool<br>    ack_deadline_seconds        = number<br>    message_retention_duration  = string<br>    retain_acked_messages       = bool<br>    filter                      = string<br>    enable_message_ordering     = bool<br>    message_ttl                 = optional(string)<br>    dead_letter_policy = optional(object({<br>      topic = object({<br>        name          = string<br>        topic_labels  = map(string)<br>        subscriptions = map(object({<br>          name                        = optional(string)<br>          enable_exactly_once_delivery = bool<br>          ack_deadline_seconds        = number<br>          message_retention_duration  = string<br>          retain_acked_messages       = bool<br>          filter                      = string<br>          enable_message_ordering     = bool<br>          message_ttl                 = optional(string)<br>          max_delivery_attempts       = number<br>        }))<br>      })<br>      max_delivery_attempts = number<br>    }))<br>    retry_policy = optional(object({<br>      maximum_backoff = string<br>      minimum_backoff = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_svpc_host_project_id"></a> [svpc\_host\_project\_id](#input\_svpc\_host\_project\_id) | Shared VPC host project ID | `string` | `null` | no |
| <a name="input_topic_kms_key_name"></a> [topic\_kms\_key\_name](#input\_topic\_kms\_key\_name) | The KMS key name for the Pub/Sub topic | `string` | `""` | no |
| <a name="input_topic_labels"></a> [topic\_labels](#input\_topic\_labels) | Labels for the Pub/Sub topic | `map(string)` | `{}` | no |
| <a name="input_usage_bucket_name"></a> [usage\_bucket\_name](#input\_usage\_bucket\_name) | Name of the usage bucket | `string` | `null` | no |
| <a name="input_usage_bucket_prefix"></a> [usage\_bucket\_prefix](#input\_usage\_bucket\_prefix) | Prefix for the usage bucket | `string` | `null` | no |
| <a name="input_vpc_service_control_attach_enabled"></a> [vpc\_service\_control\_attach\_enabled](#input\_vpc\_service\_control\_attach\_enabled) | Enable VPC service control attachment | `bool` | `false` | no |
| <a name="input_vpc_service_control_perimeter_name"></a> [vpc\_service\_control\_perimeter\_name](#input\_vpc\_service\_control\_perimeter\_name) | Name of the VPC service control perimeter | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pubsub_dl_subscriptions"></a> [pubsub\_dl\_subscriptions](#output\_pubsub\_dl\_subscriptions) | The names of the created dead letter Pub/Sub subscriptions |
| <a name="output_pubsub_dl_topic_names"></a> [pubsub\_dl\_topic\_names](#output\_pubsub\_dl\_topic\_names) | The names of the created dead letter Pub/Sub topics |
| <a name="output_pubsub_subscriptions"></a> [pubsub\_subscriptions](#output\_pubsub\_subscriptions) | The names of the created Pub/Sub subscriptions |
| <a name="output_pubsub_topic_name"></a> [pubsub\_topic\_name](#output\_pubsub\_topic\_name) | The name of the created Pub/Sub topic |
<!-- END_TF_DOCS -->