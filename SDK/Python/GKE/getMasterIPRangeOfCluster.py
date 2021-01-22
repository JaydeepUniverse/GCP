from google.cloud import resource_manager
from google.cloud import container_v1

projectList = resource_manager.Client()

for project in projectList.list_projects():
    client=container_v1.ClusterManagerClient()
    clusterDetails=client.list_clusters(parent="projects/"+project.project_id+"/locations/-")
    for clusterName in clusterDetails.clusters:
        print ("Cluster Name: " + clusterName.name + " ---- Master IP Range: " + clusterName.private_cluster_config.master_ipv4_cidr_block)
