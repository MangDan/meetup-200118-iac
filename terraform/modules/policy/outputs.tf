
# Output variables from created autonomous database
output "policy" {
  value = "${data.oci_identity_policies.policies.policies}"
}
