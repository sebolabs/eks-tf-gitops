module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = local.aws_account_level_id
  tags = tomap({ Name = local.aws_account_level_id })

  cidr            = var.vpc_cidr
  public_subnets  = var.public_subnets_cidrs
  private_subnets = var.private_subnets_cidrs
  azs             = data.aws_availability_zones.available.names

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true

  enable_flow_log                                 = var.vpc_enable_flow_log
  create_flow_log_cloudwatch_log_group            = local.create_flow_log_cwlg
  create_flow_log_cloudwatch_iam_role             = local.create_flow_log_cw_iam_role
  flow_log_destination_type                       = local.flow_log_destination_type
  flow_log_destination_arn                        = local.flow_log_destination_arn
  flow_log_cloudwatch_log_group_retention_in_days = var.vpc_flow_logs_retention_days
  flow_log_file_format                            = "plain-text"
  flow_log_log_format                             = chomp(trimspace(file("${path.module}/files/vpc-flow-log-format")))

  manage_default_network_acl    = true
  default_network_acl_name      = "${local.aws_account_level_id}-default"
  default_network_acl_tags      = { Name = "${local.aws_account_level_id}-default" }
  manage_default_route_table    = true
  default_route_table_name      = "${local.aws_account_level_id}-default"
  default_route_table_tags      = { Name = "${local.aws_account_level_id}-default" }
  manage_default_security_group = true
  default_security_group_name   = "${local.aws_account_level_id}-default"
  default_security_group_tags   = { Name = "${local.aws_account_level_id}-default" }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}
