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

resource "aws_lb_target_group" "target_group" {
  name = "${var.env}-targetgroup"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  count            = length(var.instance_ids)
  target_id        = element(var.instance_ids, count.index % 2)
  port             = 80
}

resource "aws_alb_listener" "alb_listener"{
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

# resource "aws_lb_listener_rule" {

# }