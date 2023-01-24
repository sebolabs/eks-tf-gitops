data "aws_iam_openid_connect_provider" "github" {
  count = var.github_actions_oidc_enable && var.github_actions_oidc_provider_exists ? 1 : 0
  url   = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github" {
  count           = var.github_actions_oidc_enable || var.github_actions_oidc_provider_exists ? 0 : 1
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

data "aws_iam_policy_document" "github_actions_assume_role" {
  count = var.github_actions_oidc_enable ? 1 : 0

  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_actions_linked_repo}:*"]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  count              = var.github_actions_oidc_enable ? 1 : 0
  name               = "${local.aws_account_level_id}-github-actions"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role[0].json
  tags               = tomap({ "Name" = "${local.aws_account_level_id}-github-actions" })
}

resource "aws_iam_role_policy_attachment" "github_actions" {
  count      = var.github_actions_oidc_enable ? 1 : 0
  role       = aws_iam_role.github_actions[0].name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
