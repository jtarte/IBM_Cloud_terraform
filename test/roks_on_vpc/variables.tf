###############################################################################
# The list of input variables managed by the ROKS script
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

# Flavor of machines used for worker nodes
variable "flavor" {}
# target version of Openshift
variable "kube_version" {}
# number of workers per zone 
variable "worker_count" {}
# Target region on IBM Cloud 
variable "region" {}
# the resource group to use
variable "resource_group" {}
# name on the ROKS instance
variable "cluster_name" {}
#name of the worker pool
variable "worker_pool_name" {}
# ID of a COS instance
variable "cos_instance_crn"{}
# entitlment for OpenShift
variable "entitlement" {}
#ssh key
variable "ssh_key_public" {}