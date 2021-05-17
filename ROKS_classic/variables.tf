###############################################################################
# The list of variables managed by the script
#
# author: Jérôme TARTE
# team: SWAT automation, IBM Cloud Experts lab
# email: jerome.tarte@fr.ibm.com
###############################################################################

# API KEY to interact with IBM Cloud 
variable "ibmcloud_api_key" {
    default = "" 
    description ="IBM Cloud API key allowing terrafrom to create interact with IBM Cloud resources"
}

# the name of the cluster
variable "cluster_name"{
    description = "name of the cluster"

}

# the targeted region
variable "region" {
  default = "eu-de"
  description = "region in IBM cloud targeted by the IBM terraform provider"
}

# the targeted datacenter
variable "datacenter" {
  default="fra05"
  description = "datacenter where the cluster will be deployed"
}

# size of worker pool
variable "workers_pool_size" {
  default=2
  description = "size of the worker pool"
}

# selected flavor of hardware  
variable "machine_type" {
  default= "b3c.4x16"
  description = "flavor of hardware node provisioned"
}

# type of hardware (shared / dedicated)
variable "hardware" {
  default= "shared"
  description = "shared (default) or dedicated hardware"
}

# Openshift version
variable "kube_version" {
  default="4.6_openshift"
  description = "version of cluster to be deployed"
}

# public vlan id
variable "public_vlan_id" {
  default=""
  description = "the id of public vlan to be used. If not filled, one will be created"
}

# private vlan id
variable private_vlan_id{
  default=""
  description = "the id of private vlan to be used. If not filled, one will be created"
}

# targeted resource group
variable resource_group {
  default="default"
  description = "the name of the resource group on which the cluster will be deployed"
}

# management of cluster associated deletion
variable storage_deletion {
  default = true
  description = "state if the cluster associated storage should be be deleted when the cluster is destroyed"
}

