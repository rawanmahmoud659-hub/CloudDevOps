terraform {
  backend "s3" {
    bucket       = "devops-s33-ivolve"
    key          = "eks/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
   
  }
}
