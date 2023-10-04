locals {
  project = {
    id             = "<YOUR GCP PROJECT ID>"
    number         = "<YOUR GCP PROJECT NUMBER>"
    default_region = "<DEFAULT REGION>"
    default_zone   = "<DEFAULT ZONE>"
  }

  labels = {
    env = "dev"
  }

  activate_apis = [
    "cloudapis.googleapis.com",
    "cloudbuild.googleapis.com",
    "compute.googleapis.com",
    "artifactregistry.googleapis.com",
    "iam.googleapis.com",
    "run.googleapis.com",
    "secretmanager.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "storage.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]

  dns = {
    top_domain   = "<YOUR DOMAIN>" # ex. example.com
    service_name = "main"
  }

  service_name_prometheus = "prometheus"
  prometheus = {
    registry = {
      repository_name = local.service_name_prometheus
    }
    secrets = {
      remote_write_url = {
        secret_id = "${local.service_name_prometheus}_remote_write_url"
      }
      remote_username = {
        secret_id = "${local.service_name_prometheus}_remote_username"
      }
      remote_password = {
        secret_id = "${local.service_name_prometheus}_remote_password"
      }
    }
  }

  service_name_prometheus_cluster = "prometheus-cluster"
  prometheus_cluster = {
    lb = {
      service_name = local.service_name_prometheus_cluster
      domain       = "prometheus.${local.dns.top_domain}"
    }
    cloud_run = {
      name               = local.service_name_prometheus_cluster
      ingress            = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
      cpu_idle           = false
      memory             = "512Mi"
      cpu                = "1000m"
      min_instance_count = 1
      port               = 9090
    }
  }
}
