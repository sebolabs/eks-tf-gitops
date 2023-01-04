output "__AWS_ACCOUNT_LEVEL_IDENTIFIER__" {
  value = upper(local.aws_account_level_id)
}

output "github_actions_iam_role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "s3_bucket_logs_arn" {
  value = var.enable_s3_bukcet_logs ? module.s3_bucket_logs[0].bucket.arn : null
}

output "s3_bucket_athena_bucket_name" {
  value = var.enable_athena ? module.s3_bucket_athena[0].bucket.bucket : null
}
