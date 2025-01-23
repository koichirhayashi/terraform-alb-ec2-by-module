resource "aws_vpc" "vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.vpc.id
  for_each                = var.public_subnets.subnets
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.env}-ig"
  }

}

resource "aws_route_table" "public_route_tables" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.public_subnets.subnets
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.env}-public-route-table"
  }  
}


resource "aws_route_table_association" "public_route_associations" {
  for_each       = var.public_subnets.subnets
  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.public_route_tables[each.key].id
}