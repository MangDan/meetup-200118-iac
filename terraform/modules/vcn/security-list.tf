# Create security list to allow internet access from compute and ssh access

resource "oci_core_security_list" "private_slt" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.name_prefix}-private_slt-${random_id.random_id.dec}"
  vcn_id         = "${oci_core_virtual_network.vcn.id}"
  freeform_tags  = "${var.freeform_tags}"

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }


  ingress_security_rules {
    protocol = "6"
    source   = "${oci_core_subnet.public_subnet.cidr_block}"

    tcp_options {
      max = "22"
      min = "22"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "${oci_core_subnet.public_subnet.cidr_block}"

    tcp_options {
      max = "80"
      min = "80"
    }
  }
}

resource "oci_core_security_list" "public_slt" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.vcn.id}"
  display_name   = "${var.name_prefix}-public_slt-${random_id.random_id.dec}"
  freeform_tags  = "${var.freeform_tags}"

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "80"
      min = "80"
    }
  }
}
