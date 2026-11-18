# Cloud DevOps Terraform

Modules: VPC (two public and two private subnets across eu-north-1a/b, IGW, NAT and NACL), EKS with one managed node in each private subnet, and ECR repositories.

The existing local `terraform.tfstate` contains the VPC and ECR resources. Create a private, versioned S3 bucket in eu-north-1 with credentials that can read/write the state object and lockfile. Copy `backend.hcl.example` to `backend.hcl`, replace the bucket, then migrate the state:

```sh
terraform init -migrate-state -backend-config=backend.hcl
terraform plan
terraform apply
```

EKS and NAT incur AWS charges. Do not delete the local state until migration is verified.
