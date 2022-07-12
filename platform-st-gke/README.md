# platform-st-gke 
Creating a Google Kubernetes Engine Autopilot cluster.

# Recommended variables

(Some variables are not requerid, however default values might be applied).

1.	base_name
2.	cost_center
3.	customer
4.	network
5.  subnetwork
6.  authorized_source_ranges
7.  gke_master_ipv4_cidr_block
8.  pods_range_name
9.  services_range_name
10. region

# Variables description

- **base_name**: The name of this resource.

- **cost_center**: Used to group resource costs.

- **customer**: Customer owner of this resource.

- **network**: The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network.

- **subnetwork**: The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched.

- **authorized_source_ranges**: Addresses or CIDR blocks which are allowed to connect to GKE API Server.

- **gke_master_ipv4_cidr_block**: The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network, and it must be a /28 subnet.

- **pods_range_name**: The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses. Alternatively, cluster_ipv4_cidr_block can be used to automatically create a GKE-managed one.

- **services_range_name**: The name of the existing secondary range in the cluster's subnetwork to use for service ClusterIPs. Alternatively, services_ipv4_cidr_block can be used to automatically create a GKE-managed one.

- **region**: GCP region used for the GKE.