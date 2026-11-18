
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets_cidr
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = "${aws_vpc.main_vpc.region}${each.key}"
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-${each.key}"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets_cidr
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = "${aws_vpc.main_vpc.region}${each.key}"
  cidr_block        = each.value

  tags = {
    Name = "${var.vpc_name}-private-${each.key}"
  }
}