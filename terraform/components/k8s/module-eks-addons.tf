module "eks_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.17.0"

  depends_on = [module.eks, aws_security_group.argocd_alb_public_access_whitelist]

  tags = tomap({ Name = local.aws_account_level_id })

  eks_cluster_id       = module.eks.eks_cluster_id
  eks_cluster_endpoint = module.eks.eks_cluster_endpoint
  eks_oidc_provider    = module.eks.oidc_provider
  eks_cluster_version  = module.eks.eks_cluster_version
  eks_cluster_domain   = data.aws_route53_zone.public.name

  # EKS MANAGED ADD-ONS
  enable_amazon_eks_kube_proxy = true
  amazon_eks_kube_proxy_config = { most_recent = true }

  enable_amazon_eks_vpc_cni = true
  amazon_eks_vpc_cni_config = { most_recent = true }

  enable_amazon_eks_coredns = true
  amazon_eks_coredns_config = { most_recent = true }

  enable_amazon_eks_aws_ebs_csi_driver = true
  amazon_eks_aws_ebs_csi_driver_config = { most_recent = true }

  # ADD-ONS
  enable_argocd = true

  argocd_helm_config = {
    version = var.argocd_helm_chart_version

    values = [templatefile("${path.module}/helm_values/argocd.yaml", {
      group_name            = "add-ons"
      domain_name           = data.aws_route53_zone.public.name
      asm_cert_arn          = data.aws_acm_certificate.public.arn
      access_logs_s3_bucket = element(split(":::", var.logs_s3_bucket_arn), 1)
      security_group_id     = aws_security_group.argocd_alb_public_access_whitelist.id
      tags                  = join(", ", formatlist("%s=%s", keys(local.default_tags), values(local.default_tags)))
    })]
  }

  argocd_applications = {
    add-ons = {
      namespace          = "argocd"
      repo_url           = var.argocd_k8s_addons_git_repo["url"]
      target_revision    = var.argocd_k8s_addons_git_repo["revision"]
      path               = var.argocd_k8s_addons_git_repo["path"]
      values             = {}
      add_on_application = true
    }
  }

  argocd_manage_add_ons = true

  ## aws-for-fluentbit
  enable_aws_for_fluentbit                 = var.k8s_add_ons["enable_aws_for_fluentbit"]
  aws_for_fluentbit_cw_log_group_name      = "/aws/eks/${module.eks.eks_cluster_id}/fluentbit"
  aws_for_fluentbit_cw_log_group_retention = 3

  ## aws-load-balancer-controller
  enable_aws_load_balancer_controller = var.k8s_add_ons["enable_aws_load_balancer_controller"]

  ## cluster-autoscaler
  enable_cluster_autoscaler = var.k8s_add_ons["enable_cluster_autoscaler"]

  ## external-dns
  enable_external_dns            = var.k8s_add_ons["enable_external_dns"]
  external_dns_route53_zone_arns = [data.aws_route53_zone.public.arn]
}
