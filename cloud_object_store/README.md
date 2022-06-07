# IBM Cloud Object Storage terraform module

This module create an object storage object. The module could be used to create COS that could be requied by another other, for exemple a ROKS cluster.

The varaibles you could set are:

 variable name | description | status 
 ------------- | --------------------- | ---
`service_instance_name` | the name of the COS that will be created | Optional (default: *mycosservice*)
`service_offering` | the name of the COS offering | Optional (default: *cloud-object-storage*)
`plan` | the plan of the COS isntance | Optional (default: *standard*)

The output are:

 variable name | description 
 ------------- | --------------------- 
`cos_instance_crn` | the crm of the created COS 