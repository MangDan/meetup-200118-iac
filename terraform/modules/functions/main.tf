resource "random_id" "random_id" {
  byte_length = 2
}
resource "oci_functions_application" "application" {
  #Required
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.name_prefix}-fn-${random_id.random_id.dec}"
  subnet_ids     = ["${var.public_subnet_ocid}"]

  #Optional
  freeform_tags = "${var.freeform_tags}"
}
