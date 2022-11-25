resource "aws_dynamodb_table" "tfstate_lock" {
  name           = local.tfstate_lock_ddb_table_name
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name = local.tfstate_lock_ddb_table_name
  }
}
