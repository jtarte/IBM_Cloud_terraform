###############################################################################
# Terraform init values
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

# used version of terraform
terraform {
  required_version = ">= 0.13.0"
  required_providers {
      ibm = {
         source = "IBM-Cloud/ibm"
         #version = "1.20.0"
      }
    }
}