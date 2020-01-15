data "oci_identity_policies" "policies" {
  #Required
  compartment_id = "${var.compartment_ocid}"

  filter {
    name   = "id"
    values = ["${oci_identity_policy.policy.id}"]
  }
}

data "oci_identity_compartment" "compartment" {
  id = "${var.compartment_ocid}"
}
