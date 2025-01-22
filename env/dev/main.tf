module "network" {
  source = "../../network"

  env            = var.env
  cidr           = var.cidr
  vpc_id         = module.network.vpc_id
  public_subnets = var.public_subnets

}
module "ec2" {
  source = "../../ec2"

  ami               = var.ami
  ec2_count         = var.ec2_count
  public_subnet_ids = module.network.public_subnet_ids
  # internal_sg_id    = module.internal_sg.security_group_id
  key_name      = var.key_name
  instance_type = var.instance_type
  volume_size   = var.volume_size
  volume_type   = var.volume_type
}

module "operation-sg-1" {
  source = "../../securitygroup"

  vpc_id      = module.network.vpc_id
  from_port   = 22
  to_port     = 22
  cidr_blocks = var.operation_sg_1_cidr
}
