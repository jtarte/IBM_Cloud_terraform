###############################################################################
# Output 
#
# author: Jérôme TARTE
# team: SWAT automation, IBM Cloud Experts lab
# email: jerome.tarte@fr.ibm.com
###############################################################################


# Get the cluster config file path
output "cluster_config_file_path" {
  value = data.ibm_container_cluster_config.cluster_config.config_file_path
}
