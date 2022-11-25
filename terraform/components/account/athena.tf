resource "aws_athena_database" "main" {
  name    = replace(var.project,"-","_")
  comment = "${upper(var.project)} database"
  bucket  = module.s3_bucket_athena.bucket.bucket
}
