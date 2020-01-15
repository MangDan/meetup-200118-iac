data "oci_identity_groups" "groups" {
  #Required
  compartment_id = "${var.tenancy_ocid}"

  filter {
    name   = "name"
    values = ["${var.name_prefix}-group}"]
  }
}
