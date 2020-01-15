data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.tenancy_ocid}"
}

data "oci_database_db_systems" "db_systems" {
  #Required
  compartment_id = "${var.compartment_ocid}"

  filter {
    name   = "id"
    values = ["${oci_database_db_system.db_system.id}"]
  }
}
