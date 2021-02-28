# Provison and configure the bastion VM

This module provisions a routed network and the associated feirewal and NAT rules. 


## how to use the module

Inside your main terraform file, you could call the module to launch its execution.

Sample of bastion-vm module calling
```
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
```

## Flow  of the module

The module has the following flow:

1. Create the routed net
2. Create a firewall rule and SNAT rules for outcoing traffic on IBM Cloud public network
3. Create a firewall rule and SNAT rules for outcoing traffic on IBM Cloud service private network

## Needed variables 

The extraction script need to find these elements into the terraform.tfvars file:

name | description | sample value
---- | ----------- | ------------
routed_net |  the name of the routed network |  ocpnet
edge_gateway | name of the edge gateway | edge-fra04-94398dca
gateway_ip | ip address of the gateway | 
routed_net_pool_start | start ip of reserved pool | 172.16.0.10
routed_net_pool_end |end ip of reserved pool | 172.16.0.18
dns |  ip ddress of the internal dns | 172.16.0.10
outbound_ip | the outbound traffic ip | 161.156.9.154
external_net | name of external network | fra04-w02-tenant-external
private_service_net | name of private service network | fra04-w02-service01
private_service_access_ip | ip to access service private network | 52.117.133.144