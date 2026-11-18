variable "ecr_repos" {
  type = list(string)

   default = [
    "clouddevops-app",
    "clouddevops-backend"
  ]
}

variable "cluster_name" {
  type    = string
  default = "main-eks"
}
