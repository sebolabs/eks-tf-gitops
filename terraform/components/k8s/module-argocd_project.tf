module "argocd_project" {
  source = "../../modules/argocd_project"

  project             = var.project
  environment         = var.environment
  argocd_project_name = var.k8s_argocd_project_name

  depends_on = [
    module.eks_addons
  ]
}
