variable "oauth2_client_id" {
  type = string
}

variable "oauth2_client_secret" {
  type      = string
  sensitive = true
}

variable "user_email" {
  type      = string
  sensitive = true
}

variable "prometheus_remote_write_url" {
  type = string
}

variable "prometheus_remote_username" {
  type = string
}

variable "prometheus_remote_password" {
  type      = string
  sensitive = true
}

variable "remo_exporter_oauth_token" {
  type      = string
  sensitive = true
}
