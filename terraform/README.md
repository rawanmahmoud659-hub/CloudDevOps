# Cloud DevOps Terraform

Modules: VPC (two public and two private subnets across eu-north-1a/b, IGW, NAT and NACL), EKS with one managed node in each private subnet, and ECR repositories.

The existing local `terraform.tfstate` contains the VPC and ECR resources. Create the private, versioned S3 bucket named in `backend.tf` in eu-north-1, then migrate the state:

```sh
terraform init -migrate-state
terraform plan
terraform apply
```

Do not delete the local state until migration is verified.

EKS and NAT incur AWS charges. Do not delete the local state until migration is verified.
