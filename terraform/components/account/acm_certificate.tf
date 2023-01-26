data "aws_route53_zone" "public" {
  count = var.create_acm_certificate ? 1 : 0
  name  = var.r53_public_hosted_zone_name
}

resource "aws_acm_certificate" "wildcard" {
  count = var.create_acm_certificate ? 1 : 0

  domain_name               = data.aws_route53_zone.public[0].name
  subject_alternative_names = ["*.${data.aws_route53_zone.public[0].name}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = tomap({ "Name" = local.aws_account_level_id })
}

resource "aws_route53_record" "domain_validation" {
  for_each = {
    for dvo in aws_acm_certificate.wildcard[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public[0].zone_id
}


resource "aws_acm_certificate_validation" "domain_validation" {
  count = var.create_acm_certificate ? 1 : 0

  certificate_arn         = aws_acm_certificate.wildcard[0].arn
  validation_record_fqdns = [for record in aws_route53_record.domain_validation : record.fqdn]
}
