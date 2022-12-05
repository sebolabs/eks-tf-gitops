# CHANGELOG

## Release 1.1.0
* EKS Blueprints version updated to 4.18.0
* ArgoCD Helm chart version updated to 5.16.1 (~ ArgoCD v.2.5.3)
* AWS Load Balancer Controller chart version updated to 1.4.6
* Support for the following add-ons added:
  * AWS CloudWatch Metrics
  * AWS EFS CSI Driver
  * Metrics Server
  * Secrets Store CSI Driver
* Metrics Server enabled by default due to ArgoCD HPA configuration
* EBS CSI Driver disabled by default
* ExternalDNS and FluentBit moved to `kube-system` namespace

## Release 1.0.0
Initial release covering everything described in the [AWS EKS with Terraform and GitOps in minutes](https://medium.com/@sebolabs/aws-eks-with-terraform-and-gitops-in-minutes-b3ca33171209) blog post.

EKS Blueprints version used: 4.17.0
