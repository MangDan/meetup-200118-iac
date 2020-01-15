data "oci_functions_application" "application" {
  #Required
  application_id = "${oci_functions_application.application.id}"
}
