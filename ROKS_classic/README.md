# IBM ROKS on classic infrastructure

The material in this directory allows to instanciate an IBM ROKS Cluster on classic infrastructure. It uses a single zone of a region. 

This script creates :

* ROKS cluster working on 1 zone. It will also gerenrate the associated resources (storage, VLAN if needed ...)



This script should be executed with terraform >0.13. cf: [Getting started with IBM Cloud Provider plug-in for Terraform](https://cloud.ibm.com/docs/terraform?topic=terraform-getting-started)


## Preapre the input variables

Create a `terraform.tfvars` file with your values of variables.

The varaibles you could set are:

 variable name | description | status 
 ------------- | --------------------- | ---
`ibmcloud_api_key` | the PAI key used to interact with IBM Cloud | Required 
`cluster_name`| name of the cluster | Required
`region` | the region where the cluster will be deployed | Optional (default: *eu-de*)
`datacenter` | the targeted datacenter | Optional (default: *fra05*)
`worker_pool_size` | the number of worker nodes in the zone | Optional (default:  *2*)
`machine_type` | the machine flavor (capacity) for worker creation | Optional (default: *bc3.4x16*)
`hardware` | defined if the hardware is shared with other client or dedciated to the cluster |  Optional (default: *shared*)
`kube_version`| the version of installed container cluster | Optional (default: *4.6_openshift*)
`public_vlan_id` |  the public vlan id used by the cluster. If not set, one will be created |  Optional (default: *""*)
`private_vlan_id` |  the private vlan id used by the cluster. If not set, one will be created |  Optional (default: *""*)
`resource_group` | The ressource group used for cluster creation | Optional (default: *default*)
`storage_deletion` |  define if the storage associated to the cluster will be deleted or not when the cluster is destroyed | Optional (default: *true*)

## Execute the scripts

Init your terraform env
``` 
terraform init
```

Check what you are willing to create 
```
terraform plan
``` 

Launch the deployment of resources
```
terraform apply 
```

## Destroy your instance

To destroy your instances 
``` 
terraform destroy  
``` 

