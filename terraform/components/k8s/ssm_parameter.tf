# Note: this is to keep IPs safe while the code goes public
resource "aws_ssm_parameter" "eks_cluster_endpoint_public_access_cidrs" {
  name        = "/${var.project}/${var.environment}/${var.component}/eks-cluster-endpoint-public-access-cidrs"
  description = "A list of comma-separated CIDR blocks whitelisted to access ${upper(local.eks_cluster_name)} cluster publicly"
  type        = "SecureString"
  value       = "0.0.0.0/0"

  lifecycle {
    ignore_changes = [value] # Note: this is to allow manual overrides
  }

  tags = tomap({ Name = "${local.aws_account_level_id}-eks-cluster-public-access-cidrs" })
}
