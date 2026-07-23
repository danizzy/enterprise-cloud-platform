resource "aws_ecs_cluster" "main" {

  name = "${var.project_name}-${var.environment}-cluster"


  setting {

    name  = "containerInsights"

    value = "enabled"

  }


  tags = {

    Name = "${var.project_name}-${var.environment}-cluster"

  }

}

resource "aws_cloudwatch_log_group" "ecs" {

  name = "/ecs/${var.project_name}-${var.environment}"


  retention_in_days = 30


}

resource "aws_ecs_task_definition" "app" {


  family = "${var.project_name}-${var.environment}-task"



  network_mode = "awsvpc"



  requires_compatibilities = [

    "FARGATE"

  ]



  cpu = "512"



  memory = "1024"



  execution_role_arn = var.execution_role_arn



  task_role_arn = var.task_role_arn



  container_definitions = jsonencode([

    {

      name = "app"



      image = var.container_image



      essential = true



      portMappings = [

        {

          containerPort = var.container_port

          protocol = "tcp"

        }

      ]

      secrets = [
        {
        name = "DB_PASSWORD"

        valueFrom = "SECRET_ARN"
        }

      ]



      logConfiguration = {

        logDriver = "awslogs"


        options = {

          awslogs-group = aws_cloudwatch_log_group.ecs.name

          awslogs-region = "us-east-1"

          awslogs-stream-prefix = "ecs"

        }

      }

    }

  ])

}

resource "aws_ecs_service" "app" {


  name = "${var.project_name}-${var.environment}-service"



  cluster = aws_ecs_cluster.main.id



  task_definition = aws_ecs_task_definition.app.arn



  desired_count = 2



  launch_type = "FARGATE"



  network_configuration {


    subnets = var.private_subnets



    security_groups = [

      var.ecs_security_group_id

    ]



    assign_public_ip = false

  }



  load_balancer {


    target_group_arn = var.target_group_arn



    container_name = "app"



    container_port = var.container_port

  }



  depends_on = [

    aws_ecs_task_definition.app

  ]

}