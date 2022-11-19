###############################################################################
# The list of input variables managed by the ROKS script
#
# author: Jérôme TARTE
# team: IBM Expert Labs, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

# API KEY to interact with IBM Cloud 
variable "ibmcloud_api_key" {
    default = "" 
}

# resource group
variable "resource_group" {}


###############################################################################
# Image registry namespace
###############################################################################
variable "namespace" {
    description = " The name of the namespace."
    type = string
}

variable "tags" {
    description = "The tags that are associated with the namespace"
    default = ["custom_namespace"]
} 

###############################################################################
# Image retention policy 
###############################################################################
variable "image_per_repo" {
    description = "Determines how many images are retained in each repository when the retention policy is processed."
    type = number
    default= 10
}

variable "retain_untagged"{
    description = " Determines whether untagged images are retained when the retention policy is processed."
    type = bool
    default= false
}

###############################################################################
# users & roles
###############################################################################
variable "user"{
    description = "tab of users to grant on image registry"
    default = []
}

variable "role" {
    description = "tab of privileges associated to an users"
    default = []
}

variable "region"{
    default= "eu-de"
}
