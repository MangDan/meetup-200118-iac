resource "random_id" "random_id" {
  byte_length = 2
}
resource "oci_containerengine_cluster" "cluster" {
  #Required
  compartment_id     = "${var.compartment_ocid}"
  kubernetes_version = "${element(sort(data.oci_containerengine_cluster_option.cluster_option.kubernetes_versions), (length(data.oci_containerengine_cluster_option.cluster_option.kubernetes_versions) - 1))}"
  name               = "${var.name_prefix}-cluster-${random_id.random_id.dec}"
  vcn_id             = "${var.vcn_id}"
  options {
    #Optional
    add_ons {
      #Optional
      is_kubernetes_dashboard_enabled = "${var.container["is_kubernetes_dashboard_enabled"]}"
      is_tiller_enabled               = "${var.container["is_tiller_enabled"]}"
    }
  }
}

resource "oci_containerengine_node_pool" "node_pool" {
  #Required
  cluster_id         = "${oci_containerengine_cluster.cluster.id}"
  compartment_id     = "${var.compartment_ocid}"
  depends_on         = ["oci_containerengine_cluster.cluster"]
  kubernetes_version = "${element(sort(data.oci_containerengine_cluster_option.cluster_option.kubernetes_versions), (length(data.oci_containerengine_cluster_option.cluster_option.kubernetes_versions) - 1))}"
  name               = "${var.name_prefix}-node-${random_id.random_id.dec}"
  node_config_details {
    placement_configs {
      availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 1], "name")}"
      subnet_id           = "${var.private_subnet_ocid}"
    }
    size = "${var.container["num_nodes"]}"
  }
  node_image_name = "${var.container["node_image_name"]}"
  node_shape      = "${var.container["node_shape"]}"
}
