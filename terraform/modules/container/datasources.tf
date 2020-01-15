data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.tenancy_ocid}"
}
data "oci_containerengine_cluster_kube_config" "cluster_kube_config" {
  #Required
  cluster_id = "${oci_containerengine_cluster.cluster.id}"

  #Optional
  expiration    = "${var.container["kubecfg_expiration"]}"
  token_version = "${var.container["kubecfg_token_version"]}"
}

data "oci_containerengine_clusters" "clusters" {
  #Required
  compartment_id = "${var.compartment_ocid}"

  filter {
    name   = "id"
    values = ["${oci_containerengine_cluster.cluster.id}"]
  }
}

data "oci_containerengine_cluster_option" "cluster_option" {
  #Required
  cluster_option_id = "all"
}
