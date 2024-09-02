resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow inbound from internet"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "lb-sg"
  }

}

resource "aws_security_group_rule" "lb-ingress" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.main.cidr_block]
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group_rule" "lb-egress" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = [aws_vpc.main.cidr_block]
  security_group_id        = aws_security_group.lb_sg.id
  source_security_group_id = aws_security_group.mern-sg-id.id
}

resource "aws_security_group" "mern-sg-id" {
  name        = "lb-mern-inbound"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group_rule" "mern-ingress" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  cidr_blocks              = [aws_vpc.main.cidr_block]
  security_group_id        = aws_security_group.mern-sg-id.id
  source_security_group_id = aws_security_group.lb_sg.id
}


# resource "aws_security_group_rule" "mern-ingress" {
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   cidr_blocks              = [aws_vpc.main.cidr_block]
#   security_group_id        = aws_security_group.mern-sg-id.id
#   source_security_group_id = aws_security_group.lb_sg.id
# }

