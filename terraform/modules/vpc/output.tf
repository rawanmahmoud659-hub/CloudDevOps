output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "private_subnet_ids" {
  value = { for k, s in aws_subnet.private_subnets : k => s.id }
}

output "public_subnet_ids" {
  value = { for k, s in aws_subnet.public_subnets : k => s.id }
}
