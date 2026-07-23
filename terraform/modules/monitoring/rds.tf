resource "aws_cloudwatch_metric_alarm" "rds_cpu" {


  alarm_name = "${var.project_name}-${var.environment}-rds-high-cpu"


  metric_name = "CPUUtilization"


  namespace = "AWS/RDS"


  statistic = "Average"


  period = 300


  evaluation_periods = 2


  threshold = 80


  comparison_operator = "GreaterThanThreshold"



  dimensions = {

    DBInstanceIdentifier = var.database_identifier

  }

}


resource "aws_cloudwatch_metric_alarm" "rds_connections" {


  alarm_name = "${var.project_name}-${var.environment}-rds-high-connections"


  metric_name = "DatabaseConnections"


  namespace = "AWS/RDS"


  statistic = "Average"


  period = 300


  evaluation_periods = 2


  threshold = 100


  comparison_operator = "GreaterThanThreshold"



  dimensions = {

    DBInstanceIdentifier = var.database_identifier

  }

}

resource "aws_cloudwatch_metric_alarm" "rds_storage" {


  alarm_name = "${var.project_name}-${var.environment}-rds-low-storage"


  metric_name = "FreeStorageSpace"


  namespace = "AWS/RDS"


  statistic = "Average"


  period = 300


  evaluation_periods = 1


  threshold = 5000000000


  comparison_operator = "LessThanThreshold"



  dimensions = {

    DBInstanceIdentifier = var.database_identifier

  }

}