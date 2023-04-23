###############################################################################
# The VPC module. IT creates, if required, a new VPC
#
# author: Jérôme TARTE
# team: IBM Expert Labs, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

# local variable to determine if a new VPC need to be created or a existing one is provided
#locals {
#  create_resources = var.existing_vpc_id == null
#}

# VPC creation
resource "ibm_is_vpc" "this" {
#  count = local.create_resources ? 1 : 0
  
  address_prefix_management = "manual"
  name                      = var.vpc_name
  resource_group            = var.resource_group_id
  classic_access            = var.classic_access 
  tags                      = var.tags
}

# create public gateway to allow outbound trafic for the cluster, for each zone
resource "ibm_is_public_gateway" "public_gateway" {
#    count              = "${(local.create_resources ? 1 : 0)* var.zone_number}"
    count              = var.zone_number
    name               = "${var.vpc_name}-public-gateway-${count.index + 1}"
    vpc                = ibm_is_vpc.this.id
    zone               = "${var.region}-${count.index + 1}"
    resource_group     = var.resource_group_id
    tags               = var.tags
}

# create the ip prefix and block associated with each zone
resource "ibm_is_vpc_address_prefix" "ip_prefix" {
#  count    = "${(local.create_resources ? 1 : 0) * var.zone_number}"
  count    = var.zone_number
  name     = "${var.vpc_name}-subnet-address-prefix-${count.index + 1}"
  zone     = "${var.region}-${count.index + 1}"
  vpc      = ibm_is_vpc.this.id
  cidr     = var.ip_block[count.index]
}

# create subnet into the VPC, for each zone
resource "ibm_is_subnet" "subnet" {
#  count           = "${(local.create_resources ? 1 : 0)* var.zone_number}"
  count           = var.zone_number

  depends_on = [
    ibm_is_vpc_address_prefix.ip_prefix
  ]
  name            = "${var.vpc_name}-subnet-${count.index + 1}"
  vpc             = ibm_is_vpc.this.id
  zone            = "${var.region}-${count.index + 1}"
  ipv4_cidr_block = var.ip_block[count.index]
  public_gateway  = ibm_is_public_gateway.public_gateway[count.index].id
  resource_group  = var.resource_group_id
  tags            = var.tags
}