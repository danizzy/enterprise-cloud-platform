resource "aws_cloudwatch_dashboard" "main" {


  dashboard_name = "${var.project_name}-${var.environment}-dashboard"



  dashboard_body = jsonencode({

    widgets = [

      {

        type = "metric"

        width = 12

        height = 6


        properties = {

          title = "ECS CPU Usage"


          metrics = [

            [

              "AWS/ECS",

              "CPUUtilization",

              "ClusterName",

              var.ecs_cluster_name,

              "ServiceName",

              var.ecs_service_name

            ]

          ]


          period = 300

          stat = "Average"

        }

      }

    ]

  })

}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu" {


  alarm_name = "${var.project_name}-${var.environment}-ecs-high-cpu"



  comparison_operator = "GreaterThanThreshold"



  evaluation_periods = 2



  metric_name = "CPUUtilization"



  namespace = "AWS/ECS"



  period = 300



  statistic = "Average"



  threshold = 80



  alarm_description = "ECS CPU above 80%"



  dimensions = {


    ClusterName = var.ecs_cluster_name


    ServiceName = var.ecs_service_name

  }


}

resource "aws_cloudwatch_metric_alarm" "ecs_memory" {


  alarm_name = "${var.project_name}-${var.environment}-ecs-high-memory"



  comparison_operator = "GreaterThanThreshold"



  evaluation_periods = 2



  metric_name = "MemoryUtilization"



  namespace = "AWS/ECS"



  period = 300



  statistic = "Average"



  threshold = 80



  alarm_description = "ECS memory above 80%"



  dimensions = {


    ClusterName = var.ecs_cluster_name


    ServiceName = var.ecs_service_name

  }

}