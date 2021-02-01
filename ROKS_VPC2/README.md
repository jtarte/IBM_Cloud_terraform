# IBM ROKS on VPC gen 2

This script creates :

* a COS instance used for the OCP registry
* a VPC 
* public gateways. one per zone (3).
* subnet. one per zone (3). Thesubnet is attached to the public gateway of the zone.
* security group authorizing worker communication
* ROKS cluster working on 3 zones. 
* worker pool (Optional) 

## Execute the scripts

Create a `terraform.tfvars` file with your values of variables (if your are not using the default walues).

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

