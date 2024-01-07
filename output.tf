output "gke_cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "gke_cluster_endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}

output "gke_cluster_ca_certificate" {
  value = google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate
}


############## Cloud SQL ################ ++++ ############## Outputs ######################

output "sql_instance_name" {
  description = "The name of the Google Cloud SQL instance."
  value       = google_sql_database_instance.sql_instance.name
}

output "sql_instance_connection_name" {
  description = "The connection name of the Google Cloud SQL instance to be used in connection strings."
  value       = google_sql_database_instance.sql_instance.connection_name
}

output "sql_instance_region" {
  description = "The region of the Google Cloud SQL instance."
  value       = google_sql_database_instance.sql_instance.region
}

output "sql_instance_ip_address" {
  description = "The assigned IP address of the Google Cloud SQL instance."
  value       = google_sql_database_instance.sql_instance.ip_address
}