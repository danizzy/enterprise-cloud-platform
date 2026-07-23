resource "aws_secretsmanager_secret" "database" {


  name = "${var.project_name}/${var.environment}/database"



  description = "Database credentials"



  recovery_window_in_days = 7


  tags = {

    Name = "${var.project_name}-${var.environment}-database-secret"

  }

}

resource "aws_secretsmanager_secret_version" "database" {


  secret_id = aws_secretsmanager_secret.database.id



  secret_string = jsonencode({

    username = var.db_username

    password = var.db_password

  })


}