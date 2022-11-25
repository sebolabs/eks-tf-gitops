variable "bucket_name" {
  type        = string
  description = "The bucket name"
}

variable "module" {
  type        = string
  default     = "s3_bucket"
  description = "The module name"
}

variable "default_tags" {
  type        = map(string)
  description = "Map with default tags"
  default     = {}
}

variable "acl" {
  type        = string
  default     = "private"
  description = "The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write."
}

variable "policy_documents" {
  type        = list(any)
  default     = []
  description = "A list of valid bucket policy JSON documents. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "A boolean string that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
}

variable "versioning" {
  type        = string
  default     = "Enabled"
  description = "The state of versioning"
}

variable "logging" {
  type = object({
    bucket_name = string
    prefix      = string
  })
  default     = null
  description = "Bucket access logging configuration"
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`."
}

variable "kms_master_key_arn" {
  type        = string
  default     = null
  description = "The AWS KMS master key ARN used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default aws/s3 AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`."
}

variable "bucket_key_enabled" {
  type        = bool
  default     = false
  description = "Whether or not to use Amazon S3 Bucket Keys for SSE-KMS"
}

variable "allow_encrypted_uploads_only" {
  type        = bool
  default     = true
  description = "Set to `true` to prevent uploads of unencrypted objects to S3 bucket"
}

variable "allow_ssl_requests_only" {
  type        = bool
  default     = true
  description = "Set to `true` to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests."
}

variable "lifecycle_rules" {
  type = list(object({
    id     = string
    prefix = string
    status = string

    enable_abort_incomplete_multipart_upload = bool
    enable_glacier_transition                = bool
    enable_standard_ia_transition            = bool
    enable_current_object_expiration         = bool

    abort_incomplete_multipart_upload_days      = number
    noncurrent_version_standard_transition_days = number 
    noncurrent_version_glacier_transition_days  = number
    noncurrent_version_expiration_days          = number
    standard_transition_days                    = number
    glacier_transition_days                     = number
    expiration_days                             = number
  }))
  default     = []
  description = "A list of lifecycle rules"
}

variable "abort_incomplete_multipart_upload_days" {
  type        = number
  default     = 5
  description = "Maximum time (in days) that you want to allow multipart uploads to remain in progress"
}

variable "block_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public access lists on the bucket"
}

variable "block_public_policy" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the blocking of new public policies on the bucket"
}

variable "ignore_public_acls" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the ignoring of public access lists on the bucket"
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Set to `false` to disable the restricting of making the bucket public"
}

variable "object_lock_configuration" {
  type = object({
    mode  = string
    days  = number
    years = number
  })
  default     = null
  description = "A configuration for S3 object locking"
}
