# K8S
This configuration should be kept in a separate Git repo to detach the lifecyle of Terraform konfiguration from the lifecycle of K8s configuration and to avoid race conditions while creating resources for the first time.

For the time being, to simplify things, it is kept in one place. To be changed in the future.

## ADD-ONS

Samples source: https://github.com/aws-samples/eks-blueprints-add-ons

### Helm Charts

#### aws-for-fluent-bit
https://artifacthub.io/packages/helm/aws/aws-for-fluent-bit

#### aws-load-balancer-controller
https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller

#### cluster-autoscaler
https://artifacthub.io/packages/helm/cluster-autoscaler/cluster-autoscaler

#### external-dns
https://artifacthub.io/packages/helm/bitnami/external-dns

