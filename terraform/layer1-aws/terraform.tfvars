##########
# Common
##########
name        = "simonots"
domain_name = "simonots.site"
environment = "demo"

##########
# Network
##########
region   = "eu-central-1"
az_count = 3
allowed_ips = [
  "0.0.0.0/0"
]

single_nat_gateway = true
create_acm_certificate = true
eks_cluster_version = "1.22"
zone_id = "Z056200924MIXNGB4KD31"

##########
# EKS
##########
eks_cluster_encryption_config_enable = true

node_group_ondemand = {
  instance_types       = ["t3a.medium"]
  capacity_type        = "ON_DEMAND"
  max_capacity         = 5
  min_capacity         = 1
  desired_capacity     = 1
  force_update_version = false
}

eks_write_kubeconfig = false
