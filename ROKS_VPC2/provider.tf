###############################################################################
# The config for the IBM cloud provider used for the instance on VPC-2 
# generation
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

provider "ibm" {
  generation = 2  
  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
}