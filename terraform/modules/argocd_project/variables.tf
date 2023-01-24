variable "project" {
  description = "The project name"
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment name. Used to create project and restrict namespaces"
  type        = string
}

variable "argocd_project_name" {
  description = "A custom ArgoCD project name to override project_name-environment combination"
  type        = string
  default     = null
}
