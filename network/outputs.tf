output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = values(aws_subnet.public_subnets)[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
}