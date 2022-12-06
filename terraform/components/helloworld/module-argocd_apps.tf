module "argocd_app_hello_world" {
  source = "../../modules/argocd_app"
  count  = var.hello_world_argocd_apps != {} ? 1 : 0

  # depends_on = [] # 

  # environment = var.environment

  k8s_context = {
    aws_caller_identity_account_id = data.aws_caller_identity.current.account_id
    aws_region_name                = var.aws_region
    eks_cluster_id                 = data.terraform_remote_state.k8s.outputs.eks_cluster_name
  }

  # applications = var.hello_world_argocd_apps

  # Note: this is to pass the environemtn value
  applications = {
    for app, app_config in var.hello_world_argocd_apps : app =>
    merge({
      values = { 
        namespace   = lookup(app_config, "namespace", null) != null ? app_config.namespace : "argocd"
        environment = var.environment 
      }
    }, app_config)
  }
}
