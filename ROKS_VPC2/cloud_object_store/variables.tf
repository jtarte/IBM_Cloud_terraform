###############################################################################
# The list of variables managed by the COS script
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

# name of the COS instance
variable "service_instance_name" {
    default = "jt-cos-service2"
}
# name of the offering
variable "service_offering" {
  default = "cloud-object-storage"
}
# plan of the COS service
variable "plan" {
    default = "standard"
}
