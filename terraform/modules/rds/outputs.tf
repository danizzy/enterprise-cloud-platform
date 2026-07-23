output "database_endpoint" {

  value = aws_db_instance.postgres.endpoint

}


output "database_name" {

  value = aws_db_instance.postgres.db_name

}


output "database_port" {

  value = aws_db_instance.postgres.port

}

output "database_identifier" {

value = aws_db_instance.postgres.identifier

}