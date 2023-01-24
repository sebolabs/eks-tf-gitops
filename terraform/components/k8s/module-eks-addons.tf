module "eks_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=v4.21.0"

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

  enable_amazon_eks_aws_ebs_csi_driver = false

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
      add_on_application = true

      ##### NEW STUFF #####
      values = {
        project        = "default"
        repoUrl        = var.argocd_k8s_addons_git_repo["url"]
        targetRevision = var.argocd_k8s_addons_git_repo["revision"]
        clusterName    = local.eks_cluster_name
        region         = var.aws_region
        namespace      = var.k8s_add_ons_default_namespace

        awsForFluentBit = {
          enabled      = var.k8s_add_ons["enable_aws_for_fluentbit"]
          logGroupName = local.aws_for_fluentbit_cw_log_group_name
        }

        awsLoadBalancerController = {
          enabled         = var.k8s_add_ons["enable_aws_load_balancer_controller"]
          imageRepository = "602401143452.dkr.ecr.${var.aws_region}.amazonaws.com/amazon/aws-load-balancer-controller"
        }

        externalDns = {
          enabled      = var.k8s_add_ons["enable_external_dns"]
          zoneIdFilter = data.aws_route53_zone.public.zone_id
        }
      }
      ##### NEW STUFF #####
    }

    # Example of an additional app configuration
    # dummy = {
    #   namespace          = "bleh"
    #   repo_url           = "https://github.com/sebolabs/eks-tf-gitops-k8s.git"
    #   target_revision    = "HEAD"
    #   path               = "apps/dummy"
    #   values             = { environment = "dev" }
    # }
  }

  argocd_manage_add_ons = true

  ## aws-cloudwatch-metrics
  enable_aws_cloudwatch_metrics      = var.k8s_add_ons["enable_aws_cloudwatch_metrics"]
  aws_cloudwatch_metrics_helm_config = { namespace = var.k8s_add_ons_default_namespace }

  ## aws-efs-csi-driver
  enable_aws_efs_csi_driver      = var.k8s_add_ons["enable_aws_efs_csi_driver"]
  aws_efs_csi_driver_helm_config = { namespace = var.k8s_add_ons_default_namespace }

  ## aws-for-fluentbit
  enable_aws_for_fluentbit                 = var.k8s_add_ons["enable_aws_for_fluentbit"]
  aws_for_fluentbit_helm_config            = { namespace = var.k8s_add_ons_default_namespace }
  aws_for_fluentbit_cw_log_group_name      = local.aws_for_fluentbit_cw_log_group_name
  aws_for_fluentbit_cw_log_group_retention = 3

  ## aws-load-balancer-controller
  enable_aws_load_balancer_controller      = var.k8s_add_ons["enable_aws_load_balancer_controller"]
  aws_load_balancer_controller_helm_config = { namespace = var.k8s_add_ons_default_namespace }

  ## cluster-autoscaler
  enable_cluster_autoscaler      = var.k8s_add_ons["enable_cluster_autoscaler"]
  cluster_autoscaler_helm_config = { namespace = var.k8s_add_ons_default_namespace }

  ## csi-secrets-store-provider-aws
  # thre's nothing to pre-configure

  ## external-dns
  enable_external_dns            = var.k8s_add_ons["enable_external_dns"]
  external_dns_helm_config       = { namespace = var.k8s_add_ons_default_namespace }
  external_dns_route53_zone_arns = [data.aws_route53_zone.public.arn]

  ## metrics-server
  enable_metrics_server      = var.k8s_add_ons["enable_metrics_server"]
  metrics_server_helm_config = { namespace = var.k8s_add_ons_default_namespace }
}
