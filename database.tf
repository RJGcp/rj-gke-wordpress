resource "google_sql_database_instance" "sql_instance" {
  name             = "wordpress-cloud-sql-instance"
  database_version = "POSTGRES_13"
  region           = var.gcp_region

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      authorized_networks {
        name  = "example-cidr"
        value = "192.168.0.0/16"
      }

      # Require SSL/TLS connections
      require_ssl = true
    }

    # Enable automatic backups and PITR
    backup_configuration {
      enabled                = true
      point_in_time_recovery = true
    }
  }
}

resource "google_sql_ssl_cert" "sql_ssl_cert" {
  common_name = "sql-instance-ssl"
  instance    = google_sql_database_instance.sql_instance.name
}