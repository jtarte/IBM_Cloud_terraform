###############################################################################
# The config for the IBM cloud provider used for the instance 
#
# author: Jérôme TARTE
# team: SWAT automation, IBM Cloud Experts lab
# email: jerome.tarte@fr.ibm.com
###############################################################################

provider "ibm" {
  #generation = 2  
  ibmcloud_api_key = var.ibmcloud_api_key
  region = var.region
}