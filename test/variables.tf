###############################################################################
# The list of variables managed by the script
#
# author: Jérôme TARTE
# team: IBM Experts Lab, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

# API KEY to interact with IBM Cloud 
variable "ibmcloud_api_key" {
    default = "" 
}

# Target region on IBM Cloud 
variable "region" {
  default = "us-south"
}

# the resource group to use
variable "resource_group" {
  default = "default"
}

# the resource group to use
variable "entitlement" {
  default = ""
}
