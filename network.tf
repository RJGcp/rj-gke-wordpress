resource "google_compute_network" "private_network" {
  name                    = "wordpress-gke-network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "private_subnet" {
  name                     = "rj-network-subnet"
  ip_cidr_range            = "10.10.0.0/24"
  network                  = google_compute_network.private_network.self_link
  region                   = var.gcp_region
  private_ip_google_access = true
}