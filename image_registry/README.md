# IBM Cloud Image Registry terraform module

This module create an Image Regisry. 
The varaibles you could set are:

 variable name | description | status 
 ------------- | --------------------- | ---
`resource_group` | the name of the COS that will be created | Optional (default: *mycosservice*)
`namespace` | the name of the COS offering | Optional (default: *cloud-object-storage*)
`tags` | the plan of the COS isntance | Optional (default: *standard*)
`image_per_repo`| Defines how many images are retained in each repository when the retention policy is processed.|Optional (defaulf: *10*)
`retain_untagged`| Determines whether untagged images are retained when the retention policy is processed.|Optional (defaulf: *false*)
`user`| tab of users to grant on image registry|Optional (defaulf: *[]*)
`role`| tab of privileges associated to an user"|Optional (defaulf: *[]*)
`region` | region where the image registry is crreated | Optional (default: *eu-de*)


The output are:

 variable name | description 
 ------------- | --------------------- 
`ibm_cr_namespace` | the id of the created image registry