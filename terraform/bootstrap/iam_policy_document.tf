data "aws_iam_policy_document" "tfstate_bucket" {
  statement {
    sid     = "DenyNonSslRequests"
    effect  = "Deny"
    actions = ["*"]

    resources = [
      aws_s3_bucket.tfstate_bucket.arn,
      "${aws_s3_bucket.tfstate_bucket.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    sid       = "DenyIncorrectEncryptionHeader"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.tfstate_bucket.arn}/*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "StringNotEquals"
      values   = ["AES256"]
      variable = "s3:x-amz-server-side-encryption"
    }
  }

  statement {
    sid       = "DenyUnEncryptedObjectUploads"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.tfstate_bucket.arn}/*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "Null"
      values   = ["true"]
      variable = "s3:x-amz-server-side-encryption"
    }
  }

  dynamic "statement" {
    for_each = length(var.allowed_ro_accounts) != 0 ? [1] : []
    content {
      sid       = "AllowRoAccountsS3ListBucket"
      effect    = "Allow"
      actions   = ["s3:ListBucket"]
      resources = [aws_s3_bucket.tfstate_bucket.arn]

      principals {
        type        = "AWS"
        identifiers = concat([data.aws_caller_identity.current.account_id], var.allowed_ro_accounts)
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.allowed_ro_accounts) != 0 ? [1] : []
    content {
      sid       = "AllowRoAccountsS3GetObject"
      effect    = "Allow"
      actions   = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.tfstate_bucket.arn}/*"]

      principals {
        type        = "AWS"
        identifiers = concat([data.aws_caller_identity.current.account_id], var.allowed_ro_accounts)
      }
    }
  }
}
