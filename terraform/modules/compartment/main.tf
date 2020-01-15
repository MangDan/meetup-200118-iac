/*
 * This example file shows how to create a compartment and
 * define policies for thr compartment
 */

resource "random_id" "random_id" {
  byte_length = 2
}

resource "oci_identity_compartment" "compartment" {
  name           = "${var.name_prefix}-compartment-${random_id.random_id.dec}"
  description    = "compartment created by terraform"
  compartment_id = "${var.tenancy_ocid}"
  freeform_tags  = "${var.freeform_tags}"
}

# resource "oci_identity_policy" "policy" {
#   name           = "policy-test"
#   description    = "policy created for testing"
#   compartment_id = "${oci_identity_compartment.compartment1.id}"

#   statements = ["Allow group ${var.group_name} to manage all-resources in compartment ${oci_identity_compartment.compartment1.name}"]
# }
