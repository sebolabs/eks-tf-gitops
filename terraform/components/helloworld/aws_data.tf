data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "main" {
  name = data.terraform_remote_state.k8s.outputs.eks_cluster_name
}

data "aws_eks_cluster_auth" "main" {
  name = data.terraform_remote_state.k8s.outputs.eks_cluster_name
}
