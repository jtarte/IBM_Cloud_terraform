###############################################################################
# Definition of the VCD provider
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

provider "vcd" {
  user                 = var.vcd_user
  password             = var.vcd_password
  org                  = var.vcd_org
  url                  = var.vcd_url
  vdc                  = var.vcd_vcd
  max_retry_timeout    = 30
  allow_unverified_ssl = true
  logging              = true
}