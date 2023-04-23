###############################################################################
# The list of input variables managed by the ROKS script
#
# author: Jérôme TARTE
# team: IBM Experts Lab, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

# Flavor of machines used for worker nodes
variable "flavor" {}
# target version of Openshift
variable "kube_version" {}
# number of workers per zone 
variable "worker_per_zone_count" {
    default = 1
    description = "indicates the number of worker node per zone"
}
# Target region on IBM Cloud 
variable "region" {}
# the resource group to use
variable "resource_group_id" {}
# name on the ROKS instance
variable "cluster_name" {}
# ID of a COS instance
variable "cos_instance_crn"{}
# entitlment for OpenShift
variable "entitlement" {}

variable "vpc_name"{}

variable "create_infra_node" {
    default = false
    type = bool
    description = "indicates if a infra nodes pool should be created"
}

variable "infra_node_flavor" {
    default = "bx2.8x32"
    description = "flavor of the virtual server for infra node"
}

variable "infra_node_per_zone_count" {
    default = 1
    description = "indicates the nuber of infra node to be created per zone"
}

variable "create_storage_node" {
    default = false
    type = bool
    description = "indicates if a stroage nodes pool should be created"
}

variable "storage_node_flavor" {
    default = "bx2.16x64"
    description = "flavor of the virtual server for storage node"
}

variable "storage_node_per_zone_count"{
    default = 1
    description = "indicates the nuber of storage node to be created per zone"
}

variable "deploy_gitops"{
    default = false
    type = bool
    description = "indicate if the gitops operator and instance should be deployed on the cluster"
}

variable "create_security_group"{
    default = false
    type = bool
    description = "indicate if a security gropu should be created or not, alloqing worker communication"
}

variable "tags" {
  default = []
}

variable "storage_deletion" {
    default = false
    type = bool
    description = "inidacate if the persistent storage attached to the cluster should deleted during the deletion phase"
}