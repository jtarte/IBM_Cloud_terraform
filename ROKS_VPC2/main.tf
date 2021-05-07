###############################################################################
# This script is used to  provision an ROKS cluster on IBM Cloud.
#
# It creates COS instance for image registry, VPC infrastracture and the ROKS 
# cluster.
# The ROKS cluster is deployed on 3 zones of the targeted region.
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

# create the cos instance 
module "cos" {
  source =  "./cloud_object_store"
  service_instance_name = var.cos_service_name
  plan = var.cos_service_plan
}
# create the VPC infra and ROKS cluster 
module "cluster_and_workerpool" {
  source = "./roks_on_vpc"
  flavor = var.cluster_node_flavor
  kube_version = var.cluster_kube_version
  worker_count = var.default_worker_pool_count
  region = var.region
  resource_group = var.resource_group
  cluster_name = var.cluster_name
  worker_pool_name = var.worker_pool_name
  cos_instance_crn = module.cos.cos_instance_crn
  entitlement = var.entitlement

  depends_on = [
    module.cos.cos_instance_crn
  ]
}