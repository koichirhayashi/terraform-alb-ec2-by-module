resource "aws_alb" "alb" {
  name               = "${var.env}-lb"
  internal           = false
  load_balancer_type = "application"
  subnets = var.public_subnet_ids
  security_groups = [
    var.alb_http_sg_id,
    var.alb_https_sg_id
  ]  
  
}