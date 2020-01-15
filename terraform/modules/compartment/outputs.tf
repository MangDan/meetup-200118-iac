
# Output variables from created compartment

output "compartment_name" {
  value = "${oci_identity_compartment.compartment.name}"
}

output "compartment_id" {
  value = "${oci_identity_compartment.compartment.id}"
}
