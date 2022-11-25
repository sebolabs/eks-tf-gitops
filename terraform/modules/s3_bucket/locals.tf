locals {
  parent_module = lookup(
    var.default_tags,
    "Module",
    "",
  )

  default_tags = merge(
    var.default_tags,
    tomap({
      "Name" = var.bucket_name
      "Module" = local.parent_module == "" ? var.module : format(
        "%s/%s",
        local.parent_module,
        var.module,
      )
    })
  )
}
