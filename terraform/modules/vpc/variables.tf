variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "public_subnets_cidr" {
  type = map(string)
}

variable "private_subnets_cidr" {
  type = map(string)
}
