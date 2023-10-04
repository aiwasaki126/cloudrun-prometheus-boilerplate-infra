module "prometheus_remote_write_url" {
  source = "../modules/secret_manager"

  project = local.project
  labels  = local.labels
  presets = local.prometheus.secrets.remote_write_url
  imports = {
    service_accounts = {
      "cloud_run" : module.prometheus_cloud_run_multicontainer.cloud_run_service_account_email,
      "cloud_build" : module.prometheus_cloud_run_multicontainer.cloud_build_service_account_email
    }
  }
  secrets = {
    data = var.prometheus_remote_write_url
  }
}

module "prometheus_remote_username" {
  source = "../modules/secret_manager"

  project = local.project
  labels  = local.labels
  presets = local.prometheus.secrets.remote_username
  imports = {
    service_accounts = {
      "cloud_run" : module.prometheus_cloud_run_multicontainer.cloud_run_service_account_email,
      "cloud_build" : module.prometheus_cloud_run_multicontainer.cloud_build_service_account_email
    }
  }
  secrets = {
    data = var.prometheus_remote_username
  }
}

module "prometheus_remote_password" {
  source = "../modules/secret_manager"

  project = local.project
  labels  = local.labels
  presets = local.prometheus.secrets.remote_password
  imports = {
    service_accounts = {
      "cloud_run" : module.prometheus_cloud_run_multicontainer.cloud_run_service_account_email,
      "cloud_build" : module.prometheus_cloud_run_multicontainer.cloud_build_service_account_email
    }
  }
  secrets = {
    data = var.prometheus_remote_password
  }
}
