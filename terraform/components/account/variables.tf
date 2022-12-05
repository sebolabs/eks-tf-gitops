# GENERAL
variable "aws_region" {
  type        = string
  description = "The AWS Region"
}

variable "project" {
  type        = string
  description = "The Project name"
}

variable "environment" {
  type        = string
  description = "The environment name"
}

variable "component" {
  type        = string
  description = "The TF component name"
  default     = "account"
}

variable "tf_state_bucket_name_prefix" {
  type        = string
  description = "Terraform state bucket name prefix"
}

variable "aws_account_id" {
  type        = string
  description = "The allowed AWS account ID to prevent you from mistakenly using an incorrect one"
}

# SPECIFIC
variable "github_actions_oidc_provider_exists" {
  type        = bool
  description = "Wheather the OIDC provider for GitHub is already configured within the AWS account"
}

variable "github_actions_linked_repo" {
  type        = string
  description = "The GitHub Actions linked repo (<orgName/repoName>) used to configure a trust condition for OIDC"
}
