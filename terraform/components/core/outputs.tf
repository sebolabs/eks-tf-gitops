output "__AWS_ACCOUNT_LEVEL_IDENTIFIER__" {
  value = upper(local.aws_account_level_id)
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets_ids" {
  value = module.vpc.private_subnets
}
