###############################################################################
# Create :
#     * a VPC
#     * public gateway(s) for outbound trafic 
#     * subnet(s)
#     * security group
#     * ROKS Cluster
#     * worker pool (optional) 
#
# author: Jérôme TARTE
# team: IBM Cloud Deployment Architects (CDA)
# email: jerome.tarte@fr.ibm.com
###############################################################################


resource "random_id" "name1" {
  byte_length = 2
}

resource "random_id" "name2" {
  byte_length = 2
}

resource "random_id" "name3" {
  byte_length = 2
}

locals {
  ZONE1 = "${var.region}-1"
  ZONE2 = "${var.region}-2"
  ZONE3 = "${var.region}-3"
}

resource "ibm_is_vpc" "vpc1" {
  name = "vpc-${random_id.name1.hex}"
}

data "ibm_is_vpc" "myvpc" {
  name = ibm_is_vpc.vpc1.name
}

# create public gateway to allow outbound trafic for the cluster
resource "ibm_is_public_gateway" "testacc_gateway1" {
    name = "public-gateway1"
    vpc = ibm_is_vpc.vpc1.id
    zone = local.ZONE1
}

resource "ibm_is_public_gateway" "testacc_gateway2" {
    name = "public-gateway2"
    vpc = ibm_is_vpc.vpc1.id
    zone = local.ZONE2
}

resource "ibm_is_public_gateway" "testacc_gateway3" {
    name = "public-gateway3"
    vpc = ibm_is_vpc.vpc1.id
    zone = local.ZONE3
}

# create a security group for worker node communication 
resource "ibm_is_security_group_rule" "testacc_security_group_rule_tcp" {
    group = ibm_is_vpc.vpc1.default_security_group
    direction = "inbound"
    tcp {
        port_min = 30000
        port_max = 32767
    }
 }

# Create one subnet per zone and attache the public gateway 
resource "ibm_is_subnet" "subnet1" {
  name                     = "subnet-${random_id.name1.hex}"
  vpc                      = ibm_is_vpc.vpc1.id
  zone                     = local.ZONE1
  total_ipv4_address_count = 256
  public_gateway = ibm_is_public_gateway.testacc_gateway1.id
}

resource "ibm_is_subnet" "subnet2" {
  name                     = "subnet-${random_id.name2.hex}"
  vpc                      = ibm_is_vpc.vpc1.id
  zone                     = local.ZONE2
  total_ipv4_address_count = 256
  public_gateway = ibm_is_public_gateway.testacc_gateway2.id
}

resource "ibm_is_subnet" "subnet3" {
  name                     = "subnet-${random_id.name3.hex}"
  vpc                      = ibm_is_vpc.vpc1.id
  zone                     = local.ZONE3
  total_ipv4_address_count = 256
  public_gateway = ibm_is_public_gateway.testacc_gateway3.id
}


data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

resource "ibm_is_ssh_key" "mykey" {
    name = "mykey"
    public_key = var.ssh_key_public
}

resource "ibm_is_security_group" "bastion_security_group" {
    name = "test"
    vpc = ibm_is_vpc.vpc1.id
}


resource "ibm_is_security_group_rule" "bastion_ssh" {
    group = ibm_is_security_group.bastion_security_group.id
    direction = "inbound"
    tcp {
        port_min = 22
        port_max = 22
    }
 }

resource "ibm_is_instance" "mybastion" {
  auto_delete_volume = true
  name    = "mybastion"
  image   = "r010-3bef996a-0dd4-48cc-b857-fd03e8dfa0db"
  profile = "bx2-2x8"

  primary_network_interface {
    subnet = ibm_is_subnet.subnet1.id
    security_groups = [data.ibm_is_vpc.myvpc.default_security_group, ibm_is_security_group.bastion_security_group.id]
  }
  
  vpc  = ibm_is_vpc.vpc1.id
  zone = local.ZONE1
  keys = [ibm_is_ssh_key.mykey.id]
  depends_on = [ ibm_is_security_group.bastion_security_group]
}

resource "ibm_is_floating_ip" "bastion_floatingip" {
  name   = "bastion-public-ip"
  target = ibm_is_instance.mybastion.primary_network_interface.0.id
  depends_on = [ibm_is_instance.mybastion]
}