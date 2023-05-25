# EKS-TF-GITOPS
## General info
This is how to get a fully functional and secure EKS cluster in AWS, provisioned with Terraform and powered by ArgoCD to facilitate the configuration management by following the GitOps approach.

This solution is opinionated and developed for the purpose of testing pretty much anything by providing a solid foundation.
### Blog
It has all started with this article: [Amazon EKS with Terraform and GitOps in minutes](https://medium.com/@sebolabs/aws-eks-with-terraform-and-gitops-in-minutes-b3ca33171209)

## Functionalities
The following functionalities and capabilities are currently covered:
* General
  * VPC networking
  * EKS cluster with EKS-managed node group of SPOT instances
* Kubernetes-related
  * EKS-managed add-ons enabled by default:
    * KubeProxy
    * CoreDNS
    * VPC CNI Driver
    * EBS CSI Driver
  * ArgoCD for GitOps
  * Additional add-ons controlled with ArgoCD where the following are enabled by default:
    * Cluster Autoscaler
    * AWS Load Balancer Controller
    * External DNS
    * Metrics Server

## Change log
Check it out [here](CHANGELOG.md)

## Versions
The following versions are currently set:
* Terraform: latest 1.4
* Terraform AWS provider: 4.67
* EKS cluster: 1.26
