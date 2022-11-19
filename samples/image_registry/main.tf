###############################################################################
# This script is sample script to  provision an IBM Cloud image registry.
#
# It creates an image registry instance 
#
# author: Jérôme TARTE
# team: IBM Expert Labs WW Automation Elite Team
# email: jerome.tarte@fr.ibm.com
###############################################################################

module "roks" {
  source = "../../registry"
  resource_group = var.resource_group
  namespace = var.namespace
  user = var.user
  role = var.role
}
