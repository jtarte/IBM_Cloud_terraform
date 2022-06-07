###############################################################################
# Terraform init values
#
# author: Jérôme TARTE
# team: IBM Expert Labs, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

# used version of terraform
terraform {
  required_version = ">= 1.2.0"
  required_providers {
      ibm = {
         source = "IBM-Cloud/ibm"
         version = ">=1.4.0"
      }
    }
}