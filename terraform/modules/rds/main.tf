resource "aws_db_subnet_group" "main" {


  name = "${var.project_name}-${var.environment}-db-subnet"


  subnet_ids = var.private_subnets


  tags = {

    Name = "${var.project_name}-${var.environment}-db-subnet"

  }

}

resource "aws_db_instance" "postgres" {


  identifier = "${var.project_name}-${var.environment}-postgres"



  engine = "postgres"



  engine_version = "16"



  instance_class = "db.t3.micro"



  allocated_storage = 20



  storage_type = "gp3"



  username = var.db_username



  password = var.db_password



  db_name = "application"



  db_subnet_group_name = aws_db_subnet_group.main.name



  vpc_security_group_ids = [

    var.database_security_group_id

  ]



  publicly_accessible = false



  multi_az = true



  storage_encrypted = true



  backup_retention_period = 7



  skip_final_snapshot = true



  deletion_protection = false



  performance_insights_enabled = true
  


  performance_insights_retention_period = 7



  tags = {

    Name = "${var.project_name}-${var.environment}-database"

  }

  monitoring_interval = 60


  monitoring_role_arn = aws_iam_role.rds_monitoring.arn

}