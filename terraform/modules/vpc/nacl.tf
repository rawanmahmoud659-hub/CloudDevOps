resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.main_vpc.id
  subnet_ids = concat(
    [for s in aws_subnet.public_subnets : s.id],
    [for s in aws_subnet.private_subnets : s.id]
  )

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.vpc_name}-acl"
  }
}