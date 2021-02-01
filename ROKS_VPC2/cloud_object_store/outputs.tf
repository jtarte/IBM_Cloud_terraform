###############################################################################
# The list of output variables managed by the COS script
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

# ID of the created COS instance
output "cos_instance_crn" {
  value = ibm_resource_instance.cos_instance.id
}