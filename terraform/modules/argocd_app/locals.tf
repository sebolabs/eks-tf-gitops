locals {
  argocd_namespace = var.argocd_namespace != null ? var.argocd_namespace : "argocd"

  default_helm_application = {
    type               = "helm"
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
