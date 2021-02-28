###############################################################################
# This script provisions routed net and its stanard firewall and NAT rules
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

resource "vcd_network_routed" "net" {

  name         = var.routed_net
  edge_gateway = var.edge_gateway
  gateway      = var.gateway_ip
  description  = "ocp cluster network"

  static_ip_pool {
    start_address = var.routed_net_pool_start
    end_address   = var.routed_net_pool_end
  }

  dns1 = var.dns
}

resource "vcd_nsxv_firewall_rule" "ocpnet" {
  edge_gateway = var.edge_gateway
  name = var.routed_net

  source {
      org_networks = [var.routed_net]
  }

  destination {
    ip_addresses = ["any"]
  }

  service {
    protocol = "any"
  }
}

resource "vcd_nsxv_snat" "ocpnet-outbound" {
  edge_gateway = var.edge_gateway
  description ="ocpnet outbound"
  
  network_type = "ext"
  network_name = var.external_net

  original_address   = "${var.gateway_ip}/24"
  translated_address = var.outbound_ip
}

resource "vcd_nsxv_firewall_rule" "ocpnet-private" {
  edge_gateway = var.edge_gateway
  name = "ocpnet private"

  source {
    org_networks = [ var.routed_net ]
  }

  destination {
    gateway_interfaces = [var.private_service_net]
  }

  service {
    protocol = "any"
  }
}

resource "vcd_nsxv_snat" "ocpnet-private-outbound" {
  edge_gateway = var.edge_gateway
  description ="access to the IBM Cloud private"
  
  network_type = "ext"
  network_name = var.private_service_net

  original_address   = "${var.gateway_ip}/24"
  translated_address = var.private_service_access_ip
}