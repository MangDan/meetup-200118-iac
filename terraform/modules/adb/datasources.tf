data "oci_database_autonomous_database_wallet" "autonomous_database_wallet" {

  autonomous_database_id = "${oci_database_autonomous_database.autonomous_database.id}"
  password               = "${random_string.autonomous_database_wallet_password.result}"
  base64_encode_content  = "false"

}

data "oci_database_autonomous_database" "autonomous_database" {
  #Required
  autonomous_database_id = "${oci_database_autonomous_database.autonomous_database.id}"
}
