###############################################################################
# ROKS on VPC module
# Create;
#     * ROKS Cluster
#     * worker pool for infra node (optional)
#     * worker pool for storage node (optional)
#
# author: Jérôme TARTE
# team: IBM Experts Lab, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}

#data "ibm_resource_group" "resource_group" {
#  name = var.resource_group
#}

# create a security group for worker node communication 
resource "ibm_is_security_group_rule" "testacc_security_group_rule_tcp" {
    count = var.create_security_group ? 1 : 0
    group = data.ibm_is_vpc.vpc.default_security_group
    #name = "${var.cluster_name}-cluster-securitygroup"
    direction = "inbound"
    tcp {
        port_min = 30000
        port_max = 32767
    }
}

data "ibm_is_subnet" "subnet" {
  count =  3 #length(data.ibm_is_vpc.vpc.subnets)
  identifier = data.ibm_is_vpc.vpc.subnets[count.index].id
}

locals {
  zone_subnet_map = zipmap(data.ibm_is_subnet.subnet.*.zone, data.ibm_is_subnet.subnet.*.id)
}


# create the ROKS cluster on 3 zones 
resource "ibm_container_vpc_cluster" "cluster" {
  name                  = var.cluster_name
  vpc_id                = data.ibm_is_vpc.vpc.id
  kube_version          = var.kube_version
  flavor                = var.flavor
  worker_count          = var.worker_per_zone_count
  resource_group_id     = var.resource_group_id
  entitlement           = var.entitlement
  cos_instance_crn      = var.cos_instance_crn
  tags                  = var.tags
  force_delete_storage  = var.storage_deletion


  dynamic "zones" {
    for_each = local.zone_subnet_map
    content {
      name = zones.key
      subnet_id = zones.value
    }
  }
}


# Creation of an Infra nodes pool if required
resource "ibm_container_vpc_worker_pool" "infra_pool" {
  count = var.create_infra_node ? 1 : 0

  cluster           = ibm_container_vpc_cluster.cluster.id
  worker_pool_name  = "infra-node-pool"
  flavor            = var.infra_node_flavor
  vpc_id            = data.ibm_is_vpc.vpc.id
  worker_count      = var.infra_node_per_zone_count
  resource_group_id = var.resource_group_id
  entitlement       = var.entitlement
  labels            = { "node-role.kubernetes.io/infra" = "" } 
  
  taints {
    key= "infra"
    effect =  "NoSchedule"
    value = "true"
  }
  
  dynamic "zones" {
    for_each = local.zone_subnet_map
    content {
      name = zones.key
      subnet_id = zones.value
    }
  }
}

# Creation of a Storage nodes pool if required 
resource "ibm_container_vpc_worker_pool" "storage_pool" {
  count = var.create_storage_node ? 1 : 0

  cluster           = ibm_container_vpc_cluster.cluster.id
  worker_pool_name  = "storage-node-pool"
  flavor            = var.storage_node_flavor
  vpc_id            = data.ibm_is_vpc.vpc.id
  worker_count      = var.storage_node_per_zone_count
  resource_group_id = var.resource_group_id
  entitlement       = var.entitlement
  labels            = { "node-type" = "storage" } 
 
  
  dynamic "zones" {
    for_each = local.zone_subnet_map
    content {
      name = zones.key
      subnet_id = zones.value
    }
  }
}

# Recuperation du ficher kube config 
data "ibm_container_cluster_config" "this" {
  cluster_name_id = ibm_container_vpc_cluster.cluster.id
  config_dir = pathexpand("~")
  resource_group_id = var.resource_group_id
}

resource "null_resource" "make_kubeconfig_symlink" {
  triggers = {
    config_file_path =  data.ibm_container_cluster_config.this.config_file_path
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = "mkdir -p ~/.kube && rm -f ~/.kube/config && ln -s ${self.triggers.config_file_path} ~/.kube/config"
  }
}

# deploy the gitops operator
resource "null_resource" "gitops" {
  count = var.deploy_gitops ? 1 : 0

  provisioner "local-exec" {
   command  = "./deploy-gitops.sh"
    working_dir = "${path.module}/gitops"
  }
  depends_on = [resource.null_resource.make_kubeconfig_symlink]
}




