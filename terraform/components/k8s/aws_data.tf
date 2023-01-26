data "aws_caller_identity" "current" {}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.eks_cluster_id
}

data "aws_route53_zone" "public" {
  name = var.r53_public_hosted_zone_name
}

data "aws_acm_certificate" "public" {
  domain = var.acm_cerificate_domain != null ? var.acm_cerificate_domain : var.r53_public_hosted_zone_name
}
