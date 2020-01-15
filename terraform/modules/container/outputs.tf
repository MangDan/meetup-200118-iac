
# Output variables from created autonomous database
output "clusters_endpoints" {
  value = "${data.oci_containerengine_clusters.clusters.clusters.*.endpoints}"
}

output "kubeconfig" {
  value = "${data.oci_containerengine_cluster_kube_config.cluster_kube_config.content}"
}
