resource "random_id" "random_id" {
  byte_length = 2
}
resource "oci_identity_policy" "policy" {
  name           = "${var.name_prefix}-policy-${random_id.random_id.dec}"
  description    = "policy created by terraform"
  compartment_id = "${var.compartment_ocid}"

  statements = "${var.statements}"
}
