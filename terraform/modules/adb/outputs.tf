
# Output variables from created compartment

output "connectin_strings" {
  value = "${data.oci_database_autonomous_database.autonomous_database.connection_strings}"
}
