###############################################################################
# Main module : creating an OpenShift cluster on classic infrastructure
#
#
# author: Jérôme TARTE
# team: SWAT automation, IBM Cloud Experts lab
# email: jerome.tarte@fr.ibm.com
###############################################################################

# compute a string that will be addet to clustername
resource "random_id" "name" {
  byte_length = 4
}

# get id of targeted resource group
data "ibm_resource_group" "group" {
  name = var.resource_group
}

# create OpenShift cluster 
resource "ibm_container_cluster" "cluster" {
  name              = "${var.cluster_name}${random_id.name.hex}"
  datacenter        = var.datacenter
  default_pool_size = var.workers_pool_size
  machine_type      = var.machine_type
  resource_group_id = data.ibm_resource_group.group.id
  hardware          = var.hardware
  kube_version      = var.kube_version
  public_vlan_id    = var.public_vlan_id
  private_vlan_id   = var.private_vlan_id
  force_delete_storage = var.storage_deletion
}

# get cluster config 
data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = ibm_container_cluster.cluster.id
}

