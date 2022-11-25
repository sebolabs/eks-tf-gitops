resource "aws_s3_bucket_policy" "this" {
  bucket     = aws_s3_bucket.this.id
  policy     = data.aws_iam_policy_document.aggregated_policy.json
  depends_on = [aws_s3_bucket_public_access_block.this]
}
