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
  default     = "core"
}

variable "tf_state_bucket_name_prefix" {
  type        = string
  description = "Terraform state bucket name prefix"
}

variable "aws_account_id" {
  type        = string
  description = "The allowed AWS account ID to prevent you from mistakenly using an incorrect one"
}

variable "additional_default_tags" {
  type        = map(string)
  description = "A map with additional default tags to be applied at the AWS provider level"
  default     = {}
}

# SPECIFIC
variable "vpc_cidr" {
  type        = string
  description = "The VPC CIDR block"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "A list with public subnets CIDR blocks"
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "A list with private subnets CIDR blocks"
}

variable "vpc_flow_logs_retention_days" {
  type        = number
  description = "The number of days VPC flow logs should be retained"
  default     = 3
}

variable "vpc_flow_logs_s3_bucket_arn" {
  type        = string
  description = "The ARN of a dedicated S3 bucket for storing logs. If not provided CW LG will be configured instead."
  default     = null
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Whether to enable NAT gateway creation or not"
  default     = true
}
