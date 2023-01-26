module "eks" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.21.0"

  tags = tomap({ Name = local.aws_account_level_id })

  # EKS CLUSTER
  cluster_name    = local.eks_cluster_name
  cluster_version = var.eks_cluster_version

  vpc_id             = data.terraform_remote_state.core.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.core.outputs.private_subnets_ids

  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = local.whitelisted_public_cidrs

  create_cloudwatch_log_group            = length(var.eks_cluster_enabled_log_types) > 0 ? true : false
  cluster_enabled_log_types              = var.eks_cluster_enabled_log_types
  cloudwatch_log_group_retention_in_days = var.eks_cluster_cw_lg_retention_days

  cluster_kms_key_deletion_window_in_days = 7

  # EKS MANAGED NODE GROUPS
  # https://github.com/aws-ia/terraform-aws-eks-blueprints/blob/main/modules/aws-eks-managed-node-groups/locals.tf
  managed_node_groups = {
    default_spot = {
      node_group_name = "default-spot"

      instance_types = [var.eks_node_group_default_spot_instance_type]
      capacity_type  = "SPOT"

      subnet_ids = data.terraform_remote_state.core.outputs.private_subnets_ids

      disk_size = 30

      min_size     = 0
      desired_size = 3
      max_size     = 10

      k8s_labels = {
        Environment = var.environment
        NodeGroup   = "default-spot"
      }
    }
  }
}
