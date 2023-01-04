resource "aws_athena_database" "main" {
  count   = var.enable_athena ? 1 : 0
  name    = replace(var.project,"-","_")
  comment = "${upper(var.project)} database"
  bucket  = module.s3_bucket_athena[0].bucket.bucket
}
