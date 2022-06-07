# IBM VPC terraform module

This module creates a VPC. It create also the associated subnet and public gateway

The creation occurs only if the VPC doesn't exist. if a VPC id is provided no creation is done. this feature is uses by other module to allow the possiblity to create a new VPC or to reuse an existing one.


The variables you could set are:

 variable name | description | status 
 ------------- | --------------------- | ---
`vpc_name` | The name of the vpc| Optional (default: *null*)
`existing_vpc_id` | The id of an existing VPC | Optional (default: *null*)
`resource_group_id` | The resource group associated with this instance| Optional (default: *default*)
`classic_access`| Specify if you want to create a VPC that can connect to classic infrastructure resources. | Optional (default: *false*)
`zone_number`| The number of zones handled by the VPC. | Optional (default: *1*)
`region` | The region where the VPC is deployed | Required 
`ip_block`| the ip block used by the subnet of the VPC | Optional (default= *["10.243.0.0/24","10.243.64.0/24","10.243.128.0/24"]*)

The output are:

 variable name | description 
 ------------- | --------------------- 
`vpc_id` | the id of the created or existing VPC 