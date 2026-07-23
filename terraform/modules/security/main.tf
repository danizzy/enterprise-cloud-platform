resource "aws_security_group" "alb" {

  name = "${var.project_name}-${var.environment}-alb-sg"


  description = "Allow HTTP and HTTPS traffic"


  vpc_id = var.vpc_id


  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }


  ingress {

    from_port = 443

    to_port = 443

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }


  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }


  tags = {

    Name = "ALB Security Group"

  }

}

resource "aws_security_group" "ecs" {


  name = "${var.project_name}-${var.environment}-ecs-sg"


  description = "Allow traffic from ALB only"


  vpc_id = var.vpc_id



  ingress {

    from_port = 3000

    to_port = 3000

    protocol = "tcp"


    security_groups = [

      aws_security_group.alb.id

    ]

  }



  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [

      "0.0.0.0/0"

    ]

  }


}

resource "aws_security_group" "database" {


  name = "${var.project_name}-${var.environment}-rds-sg"


  description = "Allow PostgreSQL from ECS"


  vpc_id = var.vpc_id



  ingress {

    from_port = 5432

    to_port = 5432

    protocol = "tcp"


    security_groups = [

      aws_security_group.ecs.id

    ]

  }



  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [

      "0.0.0.0/0"

    ]

  }

}

resource "aws_iam_role" "ecs_execution" {


  name = "${var.project_name}-${var.environment}-ecs-execution-role"



  assume_role_policy = jsonencode({

    Version = "2012-10-17"


    Statement = [

      {

        Effect = "Allow"


        Principal = {

          Service = "ecs-tasks.amazonaws.com"

        }


        Action = "sts:AssumeRole"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {


  role = aws_iam_role.ecs_execution.name


  policy_arn = 

  "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"


}

resource "aws_iam_role" "ecs_task" {


  name = "${var.project_name}-${var.environment}-ecs-task-role"



  assume_role_policy = jsonencode({

    Version = "2012-10-17"


    Statement = [

      {

        Effect = "Allow"


        Principal = {

          Service = "ecs-tasks.amazonaws.com"

        }


        Action = "sts:AssumeRole"

      }

    ]

  })

}

resource "aws_iam_policy" "secrets_access" {


  name = "${var.project_name}-${var.environment}-secrets-policy"



  policy = jsonencode({

    Version = "2012-10-17"


    Statement = [

      {

        Effect = "Allow"


        Action = [

          "secretsmanager:GetSecretValue"

        ]


        Resource = "*"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "secrets" {


  role = aws_iam_role.ecs_task.name


  policy_arn = aws_iam_policy.secrets_access.arn


}

resource "aws_iam_role" "rds_monitoring" {


  name = "${var.project_name}-${var.environment}-rds-monitoring-role"


  assume_role_policy = jsonencode({

    Version = "2012-10-17"


    Statement = [

      {

        Effect = "Allow"


        Principal = {

          Service = "monitoring.rds.amazonaws.com"

        }


        Action = "sts:AssumeRole"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "rds_monitoring" {


  role = aws_iam_role.rds_monitoring.name


  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"

}