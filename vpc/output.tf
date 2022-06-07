###############################################################################
# The list of output variables managed by the VPC module
#
# author: Jérôme TARTE
# team: IBM Experts Lab, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

output "vpc_id" {
  description = "ID of the VPC"
  value = local.create_resources ? ibm_is_vpc.this[0].id : var.existing_vpc_id
}
