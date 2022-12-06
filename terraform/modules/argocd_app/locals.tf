locals {
  namespace = "argocd"

  applications = {
    for app, app_config in var.applications : app =>
    merge({
      values = {
        namespace   = lookup(app_config, "namespace", null) != null ? app_config.namespace : "argocd"
        environment = var.environment
      }
    }, app_config)
  }

  default_helm_application = {
    type               = "helm"
    namespace          = local.namespace
    target_revision    = "HEAD"
    destination        = "https://kubernetes.default.svc"
    project            = "default"
    values             = {}
    add_on_application = false
  }

  global_application_values = {
    account     = var.k8s_context.aws_caller_identity_account_id
    region      = var.k8s_context.aws_region_name
    clusterName = var.k8s_context.eks_cluster_id
  }
}
