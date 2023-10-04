provider "google" {
  project = local.project.id
}

provider "google-beta" {
  project = local.project.id
}
