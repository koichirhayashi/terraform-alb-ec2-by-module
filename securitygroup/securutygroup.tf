resource "aws_security_group" "default" {
    vpc_id = var.vpc_id
    tags = {
        Name = "${var.env}-sg-${var.sg_role}"
    }
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
    security_group_id = aws_security_group.default.id
    cidr_ipv4         = var.cidr_blocks
    ip_protocol       = "tcp"
    from_port         = var.from_port
    to_port           = var.to_port
}   

resource "aws_vpc_security_group_egress_rule" "default" {
    security_group_id = aws_security_group.default.id
    # from_port         = 0
    # to_port           = 0
    ip_protocol       = "-1"
    cidr_ipv4         = "0.0.0.0/0"   
}