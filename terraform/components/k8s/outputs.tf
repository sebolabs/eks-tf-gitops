output "__AWS_ACCOUNT_LEVEL_IDENTIFIER__" {
  value = upper(local.aws_account_level_id)
}

output "eks_cluster_name" {
  value = module.eks.eks_cluster_id
}

output "eks_kubeconfig_update_command" {
  value = "${module.eks.configure_kubectl} --alias ${module.eks.eks_cluster_id}"
}

output "argocd_url" {
  value = "https://argocd.${data.aws_route53_zone.public.name}"
}
