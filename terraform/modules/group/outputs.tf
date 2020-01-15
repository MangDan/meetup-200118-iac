
# Output variables from created compartment

output "groups" {
  value = "${data.oci_identity_groups.groups.groups}"
}

output "group_id" {
  value = "${data.oci_identity_groups.groups.id}"
}
