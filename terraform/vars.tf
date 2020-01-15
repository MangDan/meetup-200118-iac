# Variables Exported from env.sh

# Uses Default Value
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "oci_user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "home_region" {}
variable "ssh_public_key" {}
variable "availability_domain" {
  default = 1
}
variable "name_prefix" {
  default = "meetup"
}
variable "freeform_tags" {
  type = "map"

  default = {
    freeform_tags = "Freeform Tags"
  }
}
variable "defined_tags" {
  type = "map"

  default = {
    "KRSET02.ET" = "ET_TEAM:donghu.kim@oracle.com"
  }
}

# for compute module
variable "compute" {
  type = "map"

  default = {
    num_nodes      = 1
    instance_shape = "VM.Standard2.1"
  }
}

# for vm database module
# variable "dbsystem" {
#   type = "map"

#   default = {
#     "database_edition" = "ENTERPRISE_EDITION"
#     "db_version"       = "12.2.0.1"
#     "admin_password"   = "WelCome123##"
#     "character_set"    = "AL32UTF8"
#     "ncharacter_set"   = "AL16UTF16"
#     "db_workload"      = "OLTP"
#     "licence_model"    = "LICENSE_INCLUDED"
#     "node_count"       = 1
#     "shape"            = "VM.Standard2.1"
#     "source"           = "NONE"
#     "time_zone"        = "Asia/Seoul"
#   }
# }

# for container module
# variable "container" {
#   type = "map"

#   default = {
#     "kubernetes_version"              = "LATEST"
#     "is_kubernetes_dashboard_enabled" = true
#     "is_tiller_enabled"               = true
#     "node_image_name"                 = "Oracle-Linux-7.6"
#     "node_shape"                      = "VM.Standard.E2.1"
#     "num_nodes"                       = 1
#     "kubecfg_expiration"              = 10
#     "kubecfg_token_version"           = "2.0.0"
#   }
# }

# for autonomous database module
# variable "adb" {
#   type = "map"

#   default = {
#     "cpu_core_count"                                 = 1
#     "data_storage_size_in_tbs"                       = 1
#     "db_workload"                                    = "DW" #DW (ADW), OLTP (ATP)
#     "is_auto_scaling_enabled"                        = false
#     "is_dedicated"                                   = false
#     "is_preview_version_with_service_terms_accepted" = false

#   }
# }
