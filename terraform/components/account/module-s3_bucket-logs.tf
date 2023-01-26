module "s3_bucket_logs" {
  source      = "../../modules/s3_bucket"
  count       = var.enable_s3_bukcet_logs ? 1 : 0
  bucket_name = "${local.aws_global_level_id}-logs"

  allow_encrypted_uploads_only = false

  policy_documents = [
    data.aws_iam_policy_document.vpc_flow_logging[0].json,
    data.aws_iam_policy_document.lb_access_logging[0].json,
  ]

  lifecycle_rules = [{
    id     = "EntireBucket"
    status = "Enabled"
    prefix = ""

    enable_abort_incomplete_multipart_upload = true
    abort_incomplete_multipart_upload_days   = 1

    enable_standard_ia_transition               = false
    standard_transition_days                    = 0
    noncurrent_version_standard_transition_days = 0

    enable_glacier_transition                  = false
    glacier_transition_days                    = 0
    noncurrent_version_glacier_transition_days = 0

    enable_current_object_expiration   = true
    expiration_days                    = 30
    noncurrent_version_expiration_days = 1
  }]
}
