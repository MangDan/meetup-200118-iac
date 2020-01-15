data "oci_identity_compartment" "compartment" {
  id = "${oci_identity_compartment.compartment.compartment_id}"
}
