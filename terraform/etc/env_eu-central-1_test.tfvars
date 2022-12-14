#
# TEST @ EU-CENTRAL-1
#
# General
aws_account_id = "???" # TODO: provide
aws_region     = "eu-central-1"
environment    = "test"

#
# ACCOUNT (optional)
#
github_actions_oidc_provider_exists = true
github_actions_linked_repo          = "sebolabs/eks-tf-gitops" # TODO: provide

#
# CORE
#
vpc_cidr              = "10.83.0.0/16"
public_subnets_cidrs  = ["10.83.1.0/24", "10.83.2.0/24"] 
private_subnets_cidrs = ["10.83.3.0/24", "10.83.4.0/24"]

#
# K8S
#
eks_cluster_version = "1.23"

argocd_helm_chart_version = "5.16.2"

argocd_k8s_addons_git_repo = { # TODO: provide
  url      = "https://github.com/sebolabs/eks-tf-gitops.git"
  revision = "release-1-1-0"
  path     = "k8s"
}

# this should be aligned with the K8s configuration in /k8s/templates/values.yaml
k8s_add_ons = {
  enable_aws_cloudwatch_metrics       = false
  enable_aws_efs_csi_driver           = false
  enable_aws_for_fluentbit            = true
  enable_aws_load_balancer_controller = true
  enable_cluster_autoscaler           = true
  enable_external_dns                 = true
  enable_metrics_server               = true
}

logs_s3_bucket_arn = "???" # TODO: provide

#
# STARTREK
#
startrek_argocd_apps = {
  startrek = {
    project         = "sebolabs-test" # Note: created manually
    namespace       = "test-startrek"
    repo_url        = "https://github.com/sebolabs/eks-tf-gitops-k8s.git"
    target_revision = "trying-out-things-2apps"
    path            = "startrek/app"
  }
}
