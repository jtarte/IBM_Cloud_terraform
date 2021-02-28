###############################################################################
# This script provisions routed net and bastion vm to do a UPI openshift install
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################

module "network"{
  source            = "./network"
  routed_net        = var.routed_net
  edge_gateway      = var.edge_gateway
  gateway_ip        = var.routed_net_gateway
  routed_net_pool_start = var.routed_net_pool_start
  routed_net_pool_end   = var.routed_net_pool_end
  dns               = var.internal_bastion_ip
  outbound_ip       = var.outbound_ip
  external_net      = var.external_net
  private_service_net   = var.private_service_net
  private_service_access_ip  = var.private_service_access_ip
}

# module "ocp-console"{
#   source          = "./ocp-console"
#   edge_gateway    = var.edge_gateway
#   external_net    = var.external_net
#   lb_ip           = var.lb_ip
#   internal_lb_ip  = var.internal_lb_ip
# }

module "bastion-vm" {
  source              = "./bastion-vm"
  routed_net          = module.network.routed_net_name
  internal_bastion_ip = var.internal_bastion_ip
  bastion_template    = var.bastion_template
  template_catalog    = var.template_catalog
  bastion_password    = var.bastion_password
  bastion_ip          = var.bastion_ip
  external_net        = var.external_net
  edge_gateway        = var.edge_gateway

}