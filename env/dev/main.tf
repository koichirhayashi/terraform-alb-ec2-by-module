# NETWORK
module "network" {
  source = "../../network"

  internet_gateway_id = module.network.internet_gateway_id
  env            = var.env
  cidr           = var.cidr
  vpc_id         = module.network.vpc_id
  public_subnets = var.public_subnets

}

# EC2
module "ec2" {
  source = "../../ec2"
  
  env = var.env
  ami               = var.ami
  ec2_count         = var.ec2_count
  public_subnet_ids = module.network.public_subnet_ids
  internal_sg_id    = module.operation-sg-1.security_group_id
  internal_sg2_id = module.operation-sg-2.security_group_id
  key_name      = var.key_name
  instance_type = var.instance_type
  volume_size   = var.volume_size
  volume_type   = var.volume_type
}

module "operation-sg-1" {
  source = "../../securitygroup"

  env = var.env
  vpc_id      = module.network.vpc_id
  from_port   = 22
  to_port     = 22
  cidr_blocks = var.operation_sg_1_cidr
  sg_role = "operation"
}

module "operation-sg-2" {
  source = "../../securitygroup"

  env = var.env
  vpc_id      = module.network.vpc_id
  from_port   = 80
  to_port     = 80
  cidr_blocks = var.operation_sg_1_cidr
  sg_role = "operation"
}

# ALB 
module "alb" {
  source = "../../alb"

  env = var.env
  alb_http_sg_id = module.alb_http_sg.security_group_id
  alb_https_sg_id = module.alb_https_sg.security_group_id
  public_subnet_ids = module.network.public_subnet_ids
  ec2_count         = var.ec2_count
  vpc_id = module.network.vpc_id
  instance_ids = module.ec2.instance_ids
}

module "alb_http_sg" {
  source = "../../securitygroup"

  env = var.env
  vpc_id      = module.network.vpc_id
  from_port   = 80
  to_port     = 80
  cidr_blocks = var.operation_sg_1_cidr
  sg_role = "http"
}

module "alb_https_sg" {
  source = "../../securitygroup"

  env = var.env
  vpc_id      = module.network.vpc_id
  from_port   = 443
  to_port     = 443
  cidr_blocks = var.operation_sg_1_cidr
  sg_role = "https"
}