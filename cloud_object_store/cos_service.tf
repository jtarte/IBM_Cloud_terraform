###############################################################################
# Create an instance of COS service 
#
# author: Jérôme TARTE
# team: IBM Experts Lab, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################
resource "ibm_resource_instance" "cos_instance" {
  name              = var.service_instance_name
  service           = "cloud-object-storage"
  plan              = var.plan
  location          = "global"
  resource_group_id = var.resource_group_id
  tags              = var.tags
}