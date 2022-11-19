###############################################################################
# The list of output variables managed by the IBM Cloud container registry script
#
# author: Jérôme TARTE
# team: IBM Expert Labs, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

# ID of the created COS instance
output "ibm_cr_namespace" {
  value = ibm_cr_namespace.cr_namespace
}