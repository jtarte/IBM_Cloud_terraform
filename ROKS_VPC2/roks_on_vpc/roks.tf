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

# create the ROKS cluster on 3 zones 
resource "ibm_container_vpc_cluster" "cluster" {
  name              = "${var.cluster_name}-${random_id.name1.hex}"
  vpc_id            = ibm_is_vpc.vpc1.id
  kube_version      = var.kube_version
  flavor            = var.flavor
  worker_count      = var.worker_count
  resource_group_id = data.ibm_resource_group.resource_group.id
  entitlement       = var.entitlement
  cos_instance_crn  = var.cos_instance_crn

  zones {
    subnet_id = ibm_is_subnet.subnet1.id
    name      = local.ZONE1
  }
  zones {
    subnet_id = ibm_is_subnet.subnet2.id
    name      = local.ZONE2
  }
  zones {
    subnet_id = ibm_is_subnet.subnet3.id
    name      = local.ZONE3
  }
}

## worker pools are not used for the moment 
## if needed, you could uncomment the following declaration and the script will create associated worker pool

# resource "ibm_container_vpc_worker_pool" "cluster_pool2" {
#   cluster           = ibm_container_vpc_cluster.cluster.id
#   worker_pool_name  = "${var.worker_pool_name}${random_id.name2.hex}"
#   flavor            = var.flavor
#   vpc_id            = ibm_is_vpc.vpc1.id
#   worker_count      = var.worker_count
#   resource_group_id = data.ibm_resource_group.resource_group.id
#   entitlement       = var.entitlement
#   zones {
#     name      = local.ZONE1
#     subnet_id = ibm_is_subnet.subnet1.id
#   }
#   zones {
#     name      = local.ZONE2
#     subnet_id = ibm_is_subnet.subnet1.id
#   }
#   zones {
#     name      = local.ZONE2
#     subnet_id = ibm_is_subnet.subnet1.id
#   }
# }

