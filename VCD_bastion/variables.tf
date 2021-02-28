###############################################################################
# List of varaibles aniulated by the script
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################


variable "vcd_vcd" {
  type        = string
  description = "This is the name of your vcd ."
}
variable "vcd_user" {
  type        = string
  description = "vcd user to execute the commands."
}
variable "vcd_password" {
  type        = string
  description = "Tvcd user password."
}
variable "vcd_org" {
  type        = string
  description = "This is the vcd org string from the console for the environment."
}
variable "vcd_url" {
  type        = string
  description = "This is the vcd url for the environment. (default is dallas)"
  default = "https://daldir01.vmware-solutions.cloud.ibm.com/api"
}
variable "edge_gateway"{
  type        = string
  description = "name of the edge gateway of your environment"
}

variable "routed_net"{
  type        = string
  description = "name of the routed network used"
  default = "ocpnet"
}

variable "routed_net_gateway"{
  type        = string
  description = "ip of the routed net gateway"
  default = "172.16.0.1"
}
variable "routed_net_range"{
  type        = string
  description = "range of the routed network"
  default = "172.16.0.1/24"
}

variable "routed_net_pool_start"{
  type        = string
  description = "start ip of reserved pool"
  default = "172.16.0.10"
}

variable "routed_net_pool_end"{
  type        = string
  description = "end ip of reserved pool"
  default = "172.16.0.18"
}

variable "external_net"{
  type        = string
  description = "name of external network"
}

variable "private_service_net"{
  type        = string
  description = "name of private service network"
}

variable "private_service_access_ip"{
  type        = string
  description = "ip to access service private network"
}

variable "internal_bastion_ip"{
  type        = string
  description = "ip of bastion on routed network"
  default = "172.16.0.10"
}

variable "ocp_console_ip"{
  type        = string
  description = "ip ocp console"
}

variable "bastion_template"{
  type        = string
  description = "nema of the template used to create the bastion vm"
  default     = "RedHat-7-Template-Official"
}

variable "template_catalog"{
  type        = string
  description = "name of tempalte catalog"
  default     = "Public Catalog" 
}

variable "bastion_password"{
  type        = string
  description = "password of the bastion vm"
}

variable "bastion_ip"{
  type        = string
  description = "external ip of the bastion"
}

variable "internal_lb_ip"{
  type        = string
  description = "internal ip of load balancer in fromt of OCP"
}

variable "lb_ip"{
  type        = string
  description = "external ip of load balancer in fromt of OCP"
}

variable "ocp_version"{
  type        = string
  description = "version of the OCP"
}

variable "terraform_ocp_repo"{
  type        = string
  description = "place where i could find terraform script for ocp"
}

variable "domain"{
  type        = string
  description = "DOMAIN USED BY YOUR CLUSTER"
}

variable "ocp_cluster"{
  type        = string
  description = "name of your ocp cluster"
}

variable "rhel_key"{
  type        = string
  description = "the red hat subscription to register your vms. provided with your VCD instance"
}

variable "outbound_ip"{
  type        = string
  description = "tthe outbound traffic ip"

}

variable "pull_secret_file"{
  type        = string
  description = "the localation of Red Hat pull secret on your latptop"
}
