resource "aws_security_group" "argocd_alb_public_access_whitelist" {
  name        = "${local.aws_account_level_id}-argocd-public-access"
  description = "Allow public access to ArgoCD from whitelisted IPs"
  vpc_id      = data.terraform_remote_state.core.outputs.vpc_id
  tags        = tomap({ Name = "${local.aws_account_level_id}-argocd-public-access" })
}

resource "aws_security_group_rule" "argocd_ingress_whitelist_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = local.whitelisted_public_cidrs
  security_group_id = aws_security_group.argocd_alb_public_access_whitelist.id
}
