resource "google_iap_web_backend_service_iam_member" "user" {
  project             = local.project.id
  web_backend_service = module.prometheus_lb.backend_service_name
  role                = "roles/iap.httpsResourceAccessor"
  member              = "user:${var.user_email}"
}
