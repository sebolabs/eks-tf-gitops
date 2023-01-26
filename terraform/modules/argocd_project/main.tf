resource "helm_release" "argocd_project" {
  name      = local.argocd_project_name
  chart     = "${path.module}/argocd-appproject"
  version   = "1.0.0"
  namespace = local.namespace

  set {
    name  = "name"
    value = local.argocd_project_name
    type  = "string"
  }

  set {
    name  = "environment"
    value = var.environment
    type  = "string"
  }
}
