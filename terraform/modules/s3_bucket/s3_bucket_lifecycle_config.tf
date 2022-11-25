resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = length(var.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      status = rule.value.status
      id     = rule.value.id

      filter {
        prefix = rule.value.prefix
      }

      dynamic "abort_incomplete_multipart_upload" {
        for_each = rule.value.enable_abort_incomplete_multipart_upload ? [1] : []

        content {
          days_after_initiation = rule.value.abort_incomplete_multipart_upload_days
        }
      }

      dynamic "transition" {
        for_each = rule.value.enable_standard_ia_transition ? [1] : []

        content {
          days          = rule.value.standard_transition_days
          storage_class = "STANDARD_IA"
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = rule.value.enable_standard_ia_transition ? [1] : []

        content {
          noncurrent_days = rule.value.noncurrent_version_standard_transition_days
          storage_class   = "STANDARD_IA"
        }
      }

      dynamic "transition" {
        for_each = rule.value.enable_glacier_transition ? [1] : []

        content {
          days          = rule.value.glacier_transition_days
          storage_class = "GLACIER"
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = rule.value.enable_glacier_transition ? [1] : []

        content {
          noncurrent_days = rule.value.noncurrent_version_glacier_transition_days
          storage_class   = "GLACIER"
        }
      }

      dynamic "expiration" {
        for_each = rule.value.enable_current_object_expiration ? [1] : []

        content {
          days = rule.value.expiration_days
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = rule.value.enable_current_object_expiration ? [1] : []

        content {
          noncurrent_days = rule.value.noncurrent_version_expiration_days
        }
      }
    }
  }
}
