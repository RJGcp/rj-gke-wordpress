output "gke_cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "gke_cluster_endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}

output "gke_cluster_ca_certificate" {
  value = google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate
}

output "mysql_instance_connection_name" {
  value = google_sql_database_instance.mysql_instance.connection_name
}

output "mysql_database_name" {
  value = google_sql_database.wordpress_database.name
}

output "client_cert" {
  value = google_sql_ssl_cert.sql_ssl_cert.client_cert
}

output "client_key" {
  value = google_sql_ssl_cert.sql_ssl_cert.client_key
}

output "server_ca" {
  value = google_sql_ssl_cert.sql_ssl_cert.server_ca
}