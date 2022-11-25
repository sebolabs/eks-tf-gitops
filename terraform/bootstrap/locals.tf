locals {
  tfstate_lock_ddb_table_name = var.bucket_name

  default_tags = {
    Project     = var.project
    Environment = var.environment
    Component   = var.component
  }
}
