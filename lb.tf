resource "aws_lb" "public" {
  name                       = "public-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lb_sg.id]
  subnets                    = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
  enable_deletion_protection = true
  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "public-lb"
    enabled = true
  }

  tags = {
    Name = "public-lb"
  }
}

resource "aws_lb_target_group" "mern-client-tg" {
  name     = "mern-client-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "mern-client-tg-attach" {
  target_group_arn = aws_lb_target_group.mern-client-tg.arn
  target_id        = aws_instance.mern-curd.id
  port             = 8080
}

resource "aws_lb_listener_rule" "mern-client-listener-rule" {
  listener_arn = aws_lb_listener.mern-client-listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mern-client-tg.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}


resource "aws_lb_listener" "mern-client-listener" {
  load_balancer_arn = aws_lb.public.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mern-client-tg.arn
  }
}
