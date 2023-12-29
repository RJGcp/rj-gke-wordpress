resource "google_container_cluster" "gke_cluster" {
  name     = "wordpress-gke-cluster"
  location = var.gcp_region

  network    = google_compute_network.private_network.name
  subnetwork = data.google_compute_subnetwork.subnet.self_link

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "gke_node_pool" {
  name       = "wordpress-gke-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 2

  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_sql_database_instance" "mysql_instance" {
  name             = "wordpress-db"
  database_version = "MYSQL_5_7"

  settings {
    tier = "db-n1-standard-1"

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled    = true
      require_ssl     = true
      private_network = google_compute_network.private_network.self_link
    }

    location_preference {
      zone = var.gcp_zone
    }

    availability_type = "REGIONAL"
  }
}

resource "google_sql_database" "wordpress_database" {
  name       = "wordpress"
  instance   = google_sql_database_instance.mysql_instance.name
  collation  = "utf8_general_ci"
  depends_on = [google_sql_database_instance.mysql_instance]
}

resource "google_compute_network" "private_network" {
  name                    = "wordpress-gke-network"
  auto_create_subnetworks = "true"
}

data "google_compute_subnetwork" "subnet" {
  name = "default"
  region = "us-central1"
  network = google_compute_network.private_network.self_link
}