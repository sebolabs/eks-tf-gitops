variable "project" {
  type        = string
  description = "The name of the Project we are bootstrapping for"
}

variable "aws_account_id" {
  type        = string
  description = "The AWS Account ID into which we are bootstrapping"
}

variable "aws_region" {
  type        = string
  description = "The AWS Region into which we are bootstrapping"
}

variable "environment" {
  type        = string
  description = "The name of the environment for the bootstrapping process"
  default     = "bootstrap"
}

variable "component" {
  type        = string
  description = "The name of the component for the bootstrapping process"
  default     = "bootstrap"
}

variable "bucket_name" {
  type        = string
  description = "The name to use for the TFState bucket (and DDB Lock table)"
}

variable "master_account_id" {
  type        = string
  description = "The ID of the Master account"
  default     = null
}

variable "allowed_ro_accounts" {
  type        = list(any)
  description = "Read-only account IDs allowed to get objects from the bucket"
  default     = []
}
