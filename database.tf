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

