module "argocd_app_startrek" {
  source = "../../modules/argocd_app"
  count  = var.startrek_argocd_apps != {} ? 1 : 0

  environment = var.environment

  applications = var.startrek_argocd_apps

  k8s_context = {
    aws_caller_identity_account_id = data.aws_caller_identity.current.account_id
    aws_region_name                = var.aws_region
    eks_cluster_id                 = data.terraform_remote_state.k8s.outputs.eks_cluster_name
  }

  # depends_on = [] # E.g. IRSA
}
