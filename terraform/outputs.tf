output "environment" {

  value = var.environment

}


output "project_name" {

  value = var.project_name

}

output "database_endpoint" {

  value = module.rds.database_endpoint

}