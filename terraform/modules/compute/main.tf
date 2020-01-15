# This Terraform script provisions a compute instance

resource "random_id" "random_id" {
  byte_length = 2
}

# Create Compute Instance

resource "oci_core_instance" "compute_instance" {
  count               = "${var.compute["num_nodes"]}"
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 1], "name")}"
  compartment_id      = "${var.compartment_ocid}"
  #display_name = "${var.name_prefix}-instance-${random_id.random_id.dec}"
  display_name = "${var.compute["num_nodes"] != "1" ? "${var.name_prefix}-instance-${random_id.random_id.dec}-${count.index + 1}" : "${var.name_prefix}-instance-${random_id.random_id.dec}"}"
  #image = "${var.image_ocid}"
  shape = "${var.compute["instance_shape"]}"
  #subnet_id = "${var.private_subnet_ocid}"
  freeform_tags = "${var.freeform_tags}"

  create_vnic_details {
    subnet_id        = "${var.public_subnet_ocid}"
    display_name     = "${var.name_prefix}-primaryvnic-${random_id.random_id.dec}"
    assign_public_ip = true
    #hostname_label   = "${var.name_prefix}-${random_id.random_id.dec}-${count.index}"
  }

  source_details {
    source_type = "image"
    source_id   = "${local.images[var.region]}"
  }

  metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}"
  }

  timeouts {
    create = "60m"
  }
}

# https://docs.cloud.oracle.com/iaas/images
# Oracle-Linux-7.7-2019.11.12-0
locals {
  images = {
    ap-mumbai-1     = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaa46gx23hrdtxenjyt4p5cc3c4mbvyiqxcb3mmrxnmjn3rfxgvqcma"
    ap-seoul-1      = "ocid1.image.oc1.ap-seoul-1.aaaaaaaavwjewurl3nvcyq6bgpbrapk4wfwu6qz2ljlrj2yk3cfqexeq64na"
    ap-sydney-1     = "ocid1.image.oc1.ap-sydney-1.aaaaaaaae5qy5o6s2ve2lt4aetmd7s4ydpupowhs6fdl25w4qpkdidbuva5q"
    ap-tokyo-1      = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa54xb7m4f42vckxkrmtlpys32quyjfldbkhq5zsbmw2r6v5hzgvkq"
    ca-toronto-1    = "ocid1.image.oc1.ca-toronto-1.aaaaaaaagupuj5dfue6gvpmlzzppvwryu4gjatkn2hedocbxbvrtrsmnc5oq"
    eu-frankfurt-1  = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3bu75jht762mfvwroa2gdck6boqwyktztyu5dfhftcycucyp63ma"
    eu-zurich-1     = "ocid1.image.oc1.eu-zurich-1.aaaaaaaadx6lizhaqdnuabw4m5dvutmh5hkzoih373632egxnitybcripb2a"
    sa-saopaulo-1   = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa3ke6hsjwdshzoh4mtjq3m6f7rhv4c4dkfljr53kjppvtiio7nv3q"
    uk-gov-london-1 = "ocid1.image.oc4.uk-gov-london-1.aaaaaaaa45cjcaz2ywhqtcjcxtkqq4z2npe5y2c5647kjxbonrlayj3a5seq"
    uk-london-1     = "ocid1.image.oc1.uk-london-1.aaaaaaaasutdhza5wtsrxa236ewtmfa6ixezlaxwxbw7vti2wyi5oobsgoeq"
    us-ashburn-1    = "ocid1.image.oc1.iad.aaaaaaaaox73mjjcopg6damp7tssjccpp5opktr3hwgr63u2lacdt2nver5a"
    us-langley-1    = "ocid1.image.oc2.us-langley-1.aaaaaaaaxyipolnyhfw3t34nparhtlez5cbslyzbvlwxky6ph4mh4s22zmnq"
    us-luke-1       = "ocid1.image.oc2.us-luke-1.aaaaaaaa5dtevrzzxk35dwslew5e6zcqljtfu5hzolcedr467gzuqdg3ls5a"
    us-phoenix-1    = "ocid1.image.oc1.phx.aaaaaaaauuj2b3bvpbtpcyrfdvxu7tuajrwsmajhn6uhvx4oquecap63jywa"
  }
}

