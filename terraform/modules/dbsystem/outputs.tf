
# Output variables from created autonomous database
output "dbsystems" {
  value = "${data.oci_database_db_systems.db_systems.db_systems}"
}
