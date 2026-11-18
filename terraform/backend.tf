terraform {
  backend "s3" {
    bucket       = "clouddevops-terraform-state-300718421551-eu-north-1"
    key          = "clouddevops/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
    encrypt      = true
  }
}
