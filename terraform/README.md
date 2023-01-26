# TERRAFORM
TFScaffold-like Terraform code structure.

## STRUCTURE
### BIN
The `terraform.sh` script takes care of computing all the things to run Terraform consistently and without having to provide static backend configuration.

It is leveraging TFenv to use Terraform version defined per component inside `.terraform-version` files.

### BOOTSTRAP
Constain code for boostrapping Terraform S3 backend along with a DynamoDB table for state locking.

This is where you start. Check dedicated ReadMe file.

### COMPOENNTS
Root modules covering defined configurations, split logically to provide as much flexibility as possible and support more granular deployments.

### ETC
Terraform variable files (.tfvars)

Patterns:
* global.tfvars
* env_[aws region]_[environment].tfvars

### MODULES
Reusable Terraform modules.

## USAGE
Examples:

```
# account
$ bin/terraform.sh -p eks-tf-gitops -b eks-tf-gitops-tfstate -r eu-central-1 -e test -c account -a plan/apply

# core
$ bin/terraform.sh -p eks-tf-gitops -b eks-tf-gitops-tfstate -r eu-central-1 -e test -c core -a plan/apply

# k8s
$ bin/terraform.sh -p eks-tf-gitops -b eks-tf-gitops-tfstate -r eu-central-1 -e test -c k8s -a plan/apply

# k8s with the use of the `local.tfvars` file
$ bin/terraform.sh -p eks-tf-gitops -b eks-tf-gitops-tfstate -r eu-central-1 -e test -c k8s -a plan/apply -- -var-file="../../etc/local.tfvars"

# startrek
$ bin/terraform.sh -p eks-tf-gitops -b eks-tf-gitops-tfstate -r eu-central-1 -e test -c startrek -a plan/apply
```
