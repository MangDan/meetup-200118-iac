/*
 * This example file shows how to create a compartment and
 * define policies for thr compartment
 */

resource "random_id" "random_id" {
  byte_length = 2
}
resource "oci_identity_group" "group" {
  #count          = "${var.run_modules == false ? 0 : 1}"
  name           = "${var.name_prefix}-group-${random_id.random_id.dec}"
  description    = "group created by terraform"
  compartment_id = "${var.tenancy_ocid}"
  freeform_tags  = "${var.freeform_tags}"
}

resource "oci_identity_user_group_membership" "user_group_membership" {
  compartment_id = "${var.tenancy_ocid}"
  group_id       = "${oci_identity_group.group.id}"
  user_id        = "${var.user_ocid}"
}
