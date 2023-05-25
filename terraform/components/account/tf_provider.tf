terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67"
    }
  }
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = [var.aws_account_id]

  default_tags {
    tags = local.default_tags
  }
}
