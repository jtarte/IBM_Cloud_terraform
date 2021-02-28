###############################################################################
# List of varaibles aniulated by the script
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

variable "routed_net"{
  type        = string
  description = "name of the routed network used"
}

variable "edge_gateway"{
  type        = string
  description = "name of the edge gateway"
}

variable "gateway_ip"{
  type        = string
  description = "ip address of the gateway"
}

variable "routed_net_pool_start"{
  type        = string
  description = "start ip of reserved pool"
}

variable "routed_net_pool_end"{
  type        = string
  description = "end ip of reserved pool"
}

variable "dns"{
  type        = string
  description = "ip of dns server"
}

variable "outbound_ip"{
  type        = string
  description = "the outbound traffic ip"

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