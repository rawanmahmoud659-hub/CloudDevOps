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

## GitHub Actions and ECR

Terraform registers `https://token.actions.githubusercontent.com` with IAM and grants the CloudDevOps `main` branch permission to assume the publishing role. If the account already has the GitHub OIDC provider, import its ARN into `aws_iam_openid_connect_provider.github_actions` before applying.

After applying a reviewed plan, set the GitHub Actions repository variables `AWS_REGION` and `AWS_ROLE_ARN`. Use the value of `terraform output -raw gh_oidc_role` for the role. Terraform must manage the `frontend`, `auth-service`, and `roadmap-service` ECR repositories.

Each service workflow builds and scans its image. It publishes to ECR when both repository variables are set, then writes that commit's image tag to the service's Helm values on `main`. GitHub must allow the workflow token to push this commit. An Argo CD Application watching the chart on `main` can sync the resulting change.

## Optional EKS settings

Set `eks_kubernetes_version` to choose a Kubernetes version supported for your cluster. Set `eks_authentication_mode = "API_AND_CONFIG_MAP"` to enable access entries while retaining the `aws-auth` ConfigMap. AWS makes the transition to access entries one-way, so review it in the plan before applying.

For Kubernetes, apply the existing manifests in `k8s/` and supply your own credentials in `app-secret` in the `ivolve` namespace. The auth chart references its `DB_USER` and `DB_PASSWORD` keys.
