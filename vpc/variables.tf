###############################################################################
# The list of input variables managed by the VPC module
#
# author: Jérôme TARTE
# team: IBM Experts Lab, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

variable "vpc_name" {
    description = " The name of the vpc."
    type = string
}

variable "existing_vpc_id"{
    description = "the id of an existing VPC"
    type = string
    default = null
}

variable "resource_group_id" {
    description = "the resource group id associated with this instance"
    type = string
    default = "default"
}

variable "classic_access" {
    description = " Specify if you want to create a VPC that can connect to classic infrastructure resources. "
    default = false
}

variable "zone_number"{
    description ="zone number handled by the VPC"
    default = 1
}

variable "region" {
    description = "The region where the VPC will be deployed"
}

variable "ip_block" {
    description= " the ip block used by the subnet of the VPC"
    default=["10.243.0.0/24","10.243.64.0/24","10.243.128.0/24"]
}

variable "tags" {
  default = []
}
