resource "google_container_cluster" "gke_cluster" {
  name     = "wordpress-gke-cluster"
  location = var.gcp_region

  network    = google_compute_network.private_network.name
  subnetwork = google_compute_subnetwork.private_subnet.name

  # Enable private cluster
  private_cluster_config {
    enable_private_nodes    = true
    master_ipv4_cidr_block = "172.16.0.0/28"
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
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

 # Enable auto-upgrade and auto-repair
  management {
    auto_upgrade = true
    auto_repair  = true
  }
}