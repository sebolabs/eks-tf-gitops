# GENERAL
variable "aws_region" {
  type        = string
  description = "The AWS Region"
}

variable "project" {
  type        = string
  description = "The Project name"
}

variable "environment" {
  type        = string
  description = "The environment name"
}

variable "component" {
  type        = string
  description = "The TF component name"
  default     = "k8s"
}

variable "tf_state_bucket_name_prefix" {
  type        = string
  description = "Terraform state bucket name prefix"
}

variable "aws_account_id" {
  type        = string
  description = "The allowed AWS account ID to prevent you from mistakenly using an incorrect one"
}

variable "additional_default_tags" {
  type        = map(string)
  description = "A map with additional default tags to be applied at the AWS provider level"
  default     = {}
}

# SPECIFIC
variable "r53_public_hosted_zone_name" {
  type        = string
  description = "The Route53 public domain name. If no other ACM certificate domain is specified this domain will be used to refer a certificate."
}

variable "acm_cerificate_domain" {
  type        = string
  description = "The domain name associated with a valid ACM certificate"
  default     = null
}

variable "eks_cluster_version" {
  type        = string
  description = "The EKS K8s cluster version"
}

variable "eks_cluster_cw_lg_retention_days" {
  type        = number
  description = "The number of days EKS cluster logs should be retained"
  default     = 3
}

variable "eks_cluster_enabled_log_types" {
  type        = list(string)
  description = "The list of EKS cluster log types to be enabled"
  default     = ["api", "audit"]
}

variable "eks_node_group_default_spot_instance_type" {
  type        = string
  description = "The default EKS spot node group EC2 instance type"
  default     = "t3.medium"
}

variable "argocd_helm_chart_version" {
  type        = string
  description = "The ArgoCD Helm Chart version (https://github.com/argoproj/argo-helm/releases)"
}

variable "argocd_k8s_addons_git_repo" {
  type        = map(string)
  description = "A Map with details on Git repo where ArgoCD should pull K8s add-ons configuration"
}

variable "logs_s3_bucket_arn" {
  type        = string
  description = "The ARN of an existing S3 bucket for storing logs"
}

variable "k8s_add_ons" {
  type        = map(bool)
  description = "A map of K8s add-ons to be enabled or disabled"
}

variable "k8s_add_ons_default_namespace" {
  type        = string
  description = "The K8s namespace where all add-ons should be deployed to by default"
  default     = "kube-system"
}

variable "k8s_argocd_project_name" {
  description = "A custom ArgoCD project name to override project_name-environment combination"
  type        = string
  default     = null
}
