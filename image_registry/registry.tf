###############################################################################
# The list of input variables managed by the ROKS script
#
# author: Jérôme TARTE
# team: IBM Expert Labs, WW Automation Elite team
# email: jerome.tarte@fr.ibm.com
###############################################################################

# Get the target resource group 
data "ibm_resource_group" "rg" {
    name = var.resource_group
}

# Define the image registry namespace
resource "ibm_cr_namespace" "cr_namespace" {
    name = var.namespace
    resource_group_id = data.ibm_resource_group.rg.id
    tags = var.tags
}

# Define the image rgistry retention policy of the namespace 
resource "ibm_cr_retention_policy" "cr_retention_policy" {
    namespace = ibm_cr_namespace.cr_namespace.id
    images_per_repo = var.image_per_repo
    retain_untagged = var.retain_untagged
}
# define privilege policy on this registry
resource "ibm_iam_user_policy" "policy" {
    for_each = toset(var.user)
    ibm_id = each.value
    roles  = [var.role[index(var.user,each.value)]]

    resources {
        service = "container-registry"
        resource = ibm_cr_namespace.cr_namespace.id
        resource_type = "namespace"
        region = var.region
    }
}