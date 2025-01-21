module "network" {
    source = "../../network"

env = var.env
cidr = var.cidr
vpc_id = module.network.vpc_id
public_subnets      = var.public_subnets

}