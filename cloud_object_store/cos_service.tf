###############################################################################
# Create n instance of COS service 
#
# author: Jérôme TARTE
# team: IBM Experts Lab, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################
resource "ibm_resource_instance" "cos_instance" {
  name     = var.service_instance_name
  service  = var.service_offering
  plan     = var.plan
  location = "global"
}