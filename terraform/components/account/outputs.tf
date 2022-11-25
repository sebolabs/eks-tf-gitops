output "__AWS_ACCOUNT_LEVEL_IDENTIFIER__" {
  value = upper(local.aws_account_level_id)
}

output "s3_bucket_logs_arn" {
  value = module.s3_bucket_logs.bucket.arn
}

output "github_actions_iam_role_arn" {
  value = aws_iam_role.github_actions.arn
}
