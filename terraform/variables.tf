variable "aws_region" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets_cidr" {
  type = map(string)
}

variable "private_subnets_cidr" {
  type = map(string)
}

variable "ecr_repos" {
  type = list(string)
}

variable "cluster_name" {
  type = string
}

variable "min_node_size" {
  type = number
}

variable "eks_kubernetes_version" {
  description = "Optional Kubernetes version for the EKS control plane."
  type        = string
  default     = null
}

variable "eks_authentication_mode" {
  description = "Optional EKS authentication mode. API_AND_CONFIG_MAP enables EKS access entries while retaining aws-auth."
  type        = string
  default     = null
}
