/*
 * This example file shows how to create a compartment and
 * define policies for thr compartment
 */

resource "random_id" "random_id" {
  byte_length = 2
}

resource "oci_database_db_system" "db_system" {
  #Required
  availability_domain     = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 1], "name")}"
  compartment_id          = "${var.compartment_ocid}"
  database_edition        = "${var.dbsystem["database_edition"]}"
  data_storage_size_in_gb = 256

  db_home {
    #Required
    database {
      #Required
      admin_password = "${var.dbsystem["admin_password"]}"

      #Optional
      character_set = "${var.dbsystem["character_set"]}"
      db_name       = "db${random_id.random_id.dec}"
      db_workload   = "${var.dbsystem["db_workload"]}"

      freeform_tags  = "${var.freeform_tags}"
      ncharacter_set = "${var.dbsystem["ncharacter_set"]}"
      pdb_name       = "pdb${random_id.random_id.dec}"
    }

    #Optional
    db_version   = "${var.dbsystem["db_version"]}" #Required
    display_name = "${var.name_prefix}-dbhome-${random_id.random_id.dec}"
  }
  display_name    = "${var.name_prefix}-dbsystem-${random_id.random_id.dec}"
  hostname        = "${var.name_prefix}-dbsystem-${random_id.random_id.dec}" #Required
  license_model   = "${var.dbsystem["licence_model"]}"                       #Required
  node_count      = "${var.dbsystem["node_count"]}"                          #Required
  shape           = "${var.dbsystem["shape"]}"                               #Required
  ssh_public_keys = ["${var.ssh_public_key}"]                                #Required
  subnet_id       = "${var.public_subnet_ocid}"                              #Required
  domain          = "test"
  freeform_tags   = "${var.freeform_tags}"
  #time_zone       = "${var.dbsystem["time_zone"]}"

}
