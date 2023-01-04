locals {
  # GENERAL
  aws_account_level_id = format(
    "%s-%s-%s",
    var.project,
    var.environment,
    var.component,
  )

  aws_global_level_id = format(
    "%s-%s-%s-%s",
    var.project,
    data.aws_caller_identity.current.account_id,
    var.environment,
    var.component,
  )

  default_tags = merge(var.additional_default_tags, {
    Project     = var.project
    Environment = var.environment
    Component   = var.component
  })

  # SPECIFIC
  eks_cluster_name = local.aws_account_level_id

  whitelisted_public_cidrs = split(",", replace(aws_ssm_parameter.eks_cluster_endpoint_public_access_cidrs.value, " ", ""))
}
