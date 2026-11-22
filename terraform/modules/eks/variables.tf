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

variable "instance_types" {
  description = "EC2 instance types for the worker nodes"
  type        = list(string)
  default     = ["t3.small"]
}

variable "ami_type" {
  description = "AMI type for the EKS node groups"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "capacity_type" {
  description = "Capacity type for the EKS node groups (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Root EBS volume size (GiB) for each worker node"
  type        = number
  default     = 20
}

variable "node_desired_size" {
  description = "Desired number of worker nodes per private subnet / AZ"
  type        = number
  default     = 1
}

variable "node_min_size" {
  description = "Minimum number of worker nodes per private subnet / AZ"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes per private subnet / AZ"
  type        = number
  default     = 2
}

variable "cluster_version" {
  description = "Kubernetes version for EKS. Null leaves version selection to EKS."
  type        = string
  default     = null
}

variable "authentication_mode" {
  description = "EKS authentication mode. Null leaves the existing authentication mode unmanaged."
  type        = string
  default     = null

  validation {
    condition     = var.authentication_mode == null ? true : contains(["CONFIG_MAP", "API_AND_CONFIG_MAP", "API"], var.authentication_mode)
    error_message = "Use CONFIG_MAP, API_AND_CONFIG_MAP, or API for the EKS authentication mode."
  }
}
