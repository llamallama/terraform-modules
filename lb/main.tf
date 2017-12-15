resource "aws_security_group" "lb_securitygroup" {
  name        = "${var.lb_name}-sg"
  description = "Security group for ${var.lb_name}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.lb_name}-sg"
  }
}

resource "aws_lb" "lb" {
  name            = "${var.lb_name}"
  internal        = "${var.internal}"
  security_groups = ["${aws_security_group.lb_securitygroup.id}"]
  subnets         = ["${var.subnets}"]

  tags {
    Name = "${var.lb_name}"
    Environment = "${var.environment}"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.lb_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_lb.lb.arn}"
  #port              = "443"
  #protocol          = "HTTPS"
  #ssl_policy        = "ELBSecurityPolicy-2015-05"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.tg.arn}"
    type             = "forward"
  }
}
