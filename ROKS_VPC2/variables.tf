###############################################################################
# The list of variables managed by the script
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

# API KEY to interact with IBM Cloud 
variable "ibmcloud_api_key" {
    default = "" 
}

# name of the COS instance
variable "cos_service_name" {
    default = "myservice"
}

# plan of the COS service
variable "cos_service_plan" {
    default = "standard"
}

# Flavor of machines used for worker nodes
variable "cluster_node_flavor" {
    default = "bx2.16x64"
}

# target version of Openshift
variable "cluster_kube_version" {
    default = "4.5_openshift"
}

# define the number of workers per zone 
variable "default_worker_pool_count"{
    default = "2"
}

# Target region on IBM Cloud 
variable "region" {
  default = "us-south"
}

# the resource group to use
variable "resource_group" {
  default = "default"
}

# name on the ROKS instance
variable "cluster_name" {
  default = "cluster-roks-on-vpc"
}

#name of the worker pool
variable "worker_pool_name" {
  default = "workerpool"
}

# entitlment for OpenShift
# If ROKS is used for Cloud Pak instances, set this value to cloud_pak
variable "entitlement"{
  default = ""
}