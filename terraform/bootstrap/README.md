# Terraform Bootstrap
Contains resources required to create an S3 Bucket to store Terraform state files and a DynamoDB table for Terraform state locking.

The `bootstrap` Terraform code is self-contained and does not call any internal or external modules in order to ensure its integrity and reliability.

## Plan / Apply
In order to execute the bootstrapping stage for a given project / AWS region run the following: 
```bash
bin/terraform.sh -p eks-tf-gitops -b eks-tf-gitops-tfstate -r <aws-region> --bootstrap -a plan/apply

Args -p eks-tf-gitops -b eks-tf-gitops-tfstate -r <aws-region> --bootstrap -a apply

[...]

AWS Account ID: <aws-account-id>
Using S3 bucket s3://eks-tf-gitops-tfstate-<aws-account-id>-<aws-region>

[...]

Setting up S3 remote state from s3://eks-tf-gitops-tfstate-<aws-account-id>-<aws-region>/eks-tf-gitops/<aws-account-id>/<aws-region>/bootstrap/bootstrap.tfstate

[...]

Outputs:

bootstrap_tfstate_bucket_name = "eks-tf-gitops-tfstate-<aws-account-id>-<aws-region>"
bootstrap_tfstate_lock_ddbtable_name = "eks-tf-gitops-tfstate-<aws-account-id>-<aws-region>"
```
