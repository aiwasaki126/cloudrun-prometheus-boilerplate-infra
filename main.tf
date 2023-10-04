module "google_project_services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "14.3.0"
  disable_services_on_destroy = false
  project_id                  = local.project.id
  enable_apis                 = true
  activate_apis               = local.activate_apis
}

module "main_dns" {
  source = "git::https://github.com/aiwasaki126/terraform-modules-google-cloud.git//dns?ref=main"

  project = local.project
  labels  = local.labels
  presets = local.dns
}

module "prometheus_lb" {
  source = "git::https://github.com/aiwasaki126/terraform-modules-google-cloud.git//cloud_run_load_balancer?ref=main"

  project = local.project
  labels  = local.labels
  presets = local.prometheus_cluster.lb
  imports = {
    cloud_run_name = module.prometheus_cloud_run_multicontainer.cloud_run_name
    managed_zone   = module.main_dns.zone_name
  }
  secrets = {
    oauth2_client_id     = var.oauth2_client_id
    oauth2_client_secret = var.oauth2_client_secret
  }
}

module "prometheus_artifact_registry" {
  source = "git::https://github.com/aiwasaki126/terraform-modules-google-cloud.git//artifact_registry_docker?ref=main"

  project = local.project
  labels  = local.labels
  presets = local.prometheus.registry
  imports = {
    service_accounts = [
      module.prometheus_cloud_run_multicontainer.cloud_build_service_account_email,
      module.prometheus_cloud_run_multicontainer.cloud_build_service_account_email,
    ]
  }
}

module "prometheus_cloud_run_multicontainer" {
  source = "git::https://github.com/aiwasaki126/terraform-modules-google-cloud.git//cloud_run_multicontainer?ref=main"

  project = local.project
  labels  = local.labels
  presets = local.prometheus_cluster.cloud_run
  imports = {
    secrets = {
      "OAUTH_TOKEN" : module.remo_exporter_token.secret_id
    }
  }
}
