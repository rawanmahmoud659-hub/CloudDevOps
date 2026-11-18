variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "ecr_repos" {
  type    = list(string)
  default = ["clouddevops-app", "clouddevops-backend"]
}

variable "cluster_name" {
  type    = string
  default = "main-eks"
}
