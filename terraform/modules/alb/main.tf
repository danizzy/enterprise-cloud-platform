resource "aws_lb" "main" {

  name = "${var.project_name}-${var.environment}-alb"


  load_balancer_type = "application"


  internal = false


  security_groups = [

    var.security_group_id

  ]


  subnets = var.public_subnets


  enable_deletion_protection = false


  tags = {

    Name = "${var.project_name}-${var.environment}-alb"

  }

}

resource "aws_lb_target_group" "app" {


  name = "${var.project_name}-${var.environment}-tg"


  port = 3000


  protocol = "HTTP"


  target_type = "ip"


  vpc_id = var.vpc_id



  health_check {


    enabled = true


    path = "/health"


    port = "3000"


    protocol = "HTTP"


    matcher = "200"



    interval = 30


    timeout = 5


    healthy_threshold = 2


    unhealthy_threshold = 3

  }


  tags = {

    Name = "${var.project_name}-${var.environment}-target-group"

  }

}

resource "aws_lb_listener" "http" {


  load_balancer_arn = aws_lb.main.arn


  port = 80


  protocol = "HTTP"



  default_action {


    type = "forward"


    target_group_arn = aws_lb_target_group.app.arn

  }

}