data "terraform_remote_state" "core" {
  backend = "s3"

  config = {
    bucket = "${var.tf_state_bucket_name_prefix}-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
    key    = "${var.project}/${data.aws_caller_identity.current.account_id}/${var.aws_region}/${var.environment}/core.tfstate"
    region = var.aws_region
  }
}
