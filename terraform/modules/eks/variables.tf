variable "cluster_name" {
  type = string
}

variable "private_subnet_ids" {
  type = map(string)
  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "EKS requires at least two private subnets in different availability zones."
  }
}
