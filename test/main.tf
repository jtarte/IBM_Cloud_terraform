###############################################################################
# This script is used to  provision an ROKS cluster on IBM Cloud.
#
# It creates COS instance for image registry, VPC infrastracture and the ROKS 
# cluster.
# The ROKS cluster is deployed on 3 zones of the targeted region.
#
# author: Jérôme TARTE
# team: IBM Expert Labs WW Automation Elite Team
# email: jerome.tarte@fr.ibm.com
###############################################################################

data "ibm_resource_group" "rg" {
  name = var.resource_group
}

# create the VPC infra and ROKS cluster 
module "vpc"{
  source =  "../vpc"
  vpc_name = "my-vpc"
  zone_number = 3
  resource_group_id = data.ibm_resource_group.rg.id
  region = var.region
  ip_block = ["10.202.81.0/26", "10.202.81.64/26","10.202.81.128/26"]

}

# create the cos instance 
module "cos" {
  source =  "../cloud_object_store"
  service_instance_name = "my-cos"
  plan = "standard"
  resource_group_id = data.ibm_resource_group.rg.id
}

module "roks" {
  source = "../roks_on_vpc"
  flavor = "bx2.16x64"
  kube_version = "4.10_openshift"
  worker_per_zone_count = 1
  region = var.region
  resource_group_id = data.ibm_resource_group.rg.id
  cluster_name = "jt-openshift"
  cos_instance_crn = module.cos.cos_instance_crn
  entitlement = "cloud_pak"
  vpc_name = "my-vpc"

  create_infra_node = false
  create_storage_node = false
  deploy_gitops = true

  depends_on = [
    module.vpc,
    module.cos
  ]
}