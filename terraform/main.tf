/*
* This terraform script creates an User, creates Group, adds user to group,
* creates compartment, defines policy for compartment,
* creates virtual cloud network and provisions a compute instance
*/

# Creates a user

#module "user"{
#    source = "./modules/user"
#    tenancy_ocid = "${var.tenancy_ocid}"
#}

# Creates a group

# module "group" {
#   source        = "./modules/group"
#   tenancy_ocid  = "${var.tenancy_ocid}"
#   user_ocid     = "${var.oci_user_ocid}" // IDCS에서 관리하는 사용자를 추가할 경우 ${var.user_ocid}
#   name_prefix   = "${var.name_prefix}"
#   freeform_tags = "${var.freeform_tags}"
# }

# Creates a compartment

module "compartment" {
  source        = "./modules/compartment"
  tenancy_ocid  = "${var.tenancy_ocid}"
  name_prefix   = "${var.name_prefix}"
  freeform_tags = "${var.freeform_tags}"
}

# Create a Virtual Cloud Network

module "vcn" {
  source              = "./modules/vcn"
  tenancy_ocid        = "${var.tenancy_ocid}"
  compartment_ocid    = "${module.compartment.compartment_id}"
  availability_domain = "${var.availability_domain}"
  name_prefix         = "${var.name_prefix}"
  freeform_tags       = "${var.freeform_tags}"
}

# # Creates Compute Instance

module "compute" {
  source              = "./modules/compute"
  tenancy_ocid        = "${var.tenancy_ocid}"
  region              = "${var.region}"
  compartment_ocid    = "${module.compartment.compartment_id}"
  availability_domain = "${var.availability_domain}"
  compute             = "${var.compute}"
  name_prefix         = "${var.name_prefix}"
  ssh_public_key      = "${file(var.ssh_public_key)}"
  public_subnet_ocid  = "${module.vcn.public_subnet_ocid}"
  freeform_tags       = "${var.freeform_tags}"
}

# module "dbsystem" {
#   source              = "./modules/dbsystem"
#   tenancy_ocid        = "${var.tenancy_ocid}"
#   availability_domain = "${var.availability_domain}"
#   compartment_ocid    = "${module.compartment.compartment_id}"
#   #compartment_ocid   = "${var.compartment_ocid}"
#   dbsystem           = "${var.dbsystem}"
#   public_subnet_ocid = "${module.vcn.public_subnet_ocid}"
#   name_prefix        = "${var.name_prefix}"
#   ssh_public_key     = "${file(var.ssh_public_key)}"
#   freeform_tags      = "${var.freeform_tags}"
# }

# module "adb" {
#   source           = "./modules/adb"
#   compartment_ocid = "${module.compartment.compartment_id}"
#   #compartment_ocid = "${var.compartment_ocid}"
#   adb           = "${var.adb}"
#   freeform_tags = "${var.freeform_tags}"
# }

# module "container" {
#   source           = "./modules/container"
#   tenancy_ocid     = "${var.tenancy_ocid}"
#   compartment_ocid = "${module.compartment.compartment_id}"
#   #compartment_ocid = "${var.compartment_ocid}"
#   availability_domain = "${var.availability_domain}"
#   container           = "${var.container}"
#   private_subnet_ocid = "${module.vcn.private_subnet_ocid}"
#   vcn_id              = "${module.vcn.vcn_id}"
#   name_prefix         = "${var.name_prefix}"
# }

# module "functions" {
#   source = "./modules/functions"
#   #compartment_ocid = "${var.compartment_ocid}"
#   compartment_ocid   = "${module.compartment.compartment_id}"
#   public_subnet_ocid = "${module.vcn.public_subnet_ocid}"
#   name_prefix        = "${var.name_prefix}"
#   freeform_tags      = "${var.freeform_tags}"
# }

# module "policy" {
#   source = "./modules/policy"
#   #compartment_ocid = "${var.compartment_ocid}"
#   compartment_ocid = "${var.tenancy_ocid}"
#   statements       = "${local.statements}"
#   name_prefix      = "${var.name_prefix}"
#   # providers = {
#   #   oci = "oci.home"
#   # }
# }

# locals {
#   statements = [
#     "Allow service OKE to manage all-resources in tenancy", "Allow service FaaS to manage all-resources in compartment ${module.compartment.compartment_name}"
#   ]
# }
