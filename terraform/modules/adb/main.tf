# Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

# creates an ATP database
resource "random_id" "random_id" {
  byte_length = 2
}
resource "oci_database_autonomous_database" "autonomous_database" {
  #Required
  admin_password           = "${random_string.autonomous_database_wallet_password.result}"
  compartment_id           = "${var.compartment_ocid}"
  cpu_core_count           = "${var.adb["cpu_core_count"]}"
  data_storage_size_in_tbs = "${var.adb["data_storage_size_in_tbs"]}"
  db_name                  = "adb${random_id.random_id.dec}"
  freeform_tags            = "${var.freeform_tags}"
  #  is_free_tier             = true
  is_free_tier = false

  #Optional

  db_workload                                    = "${var.adb["db_workload"]}"
  display_name                                   = "adb${random_id.random_id.dec}"
  is_auto_scaling_enabled                        = "${var.adb["is_auto_scaling_enabled"]}"
  is_dedicated                                   = "${var.adb["is_dedicated"]}"
  is_preview_version_with_service_terms_accepted = "${var.adb["is_preview_version_with_service_terms_accepted"]}"

}

resource "random_string" "autonomous_database_wallet_password" {

  length           = 16
  special          = true
  min_upper        = 3
  min_lower        = 3
  min_numeric      = 3
  min_special      = 3
  override_special = "{}#^*<>[]%~"

}
