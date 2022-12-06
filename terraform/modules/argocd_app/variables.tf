variable "module" {
  type        = string
  description = "The module name"
  default     = "argocd_app"
}

variable "environment" {
  type        = string
  description = "The environment where the app belongs to"
}

variable "argocd_namespace" {
  type        = string
  description = "The namespace an app should belong to. The 'argocd' namespace is created by default on ArgoCD install."
  default     = "argocd"
}

variable "applications" {
  type        = map
  description = "The ArgoCD application name"
}

variable "k8s_context" {
  description = "K8s configuration context"
  type        = object({
    aws_caller_identity_account_id = string
    aws_region_name                = string
    eks_cluster_id                 = string
  })
}
