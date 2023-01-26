locals {
  namespace = "argocd"

  argocd_project_name = var.argocd_project_name != null ? var.argocd_project_name : "${var.project}-${var.environment}"
}
