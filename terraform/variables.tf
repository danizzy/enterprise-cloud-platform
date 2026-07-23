variable "project_name" {

  description = "Project name"

  type = string

}


variable "environment" {

  description = "Environment name"

  type = string

}


variable "aws_region" {

  description = "AWS region"

  type = string

}


variable "vpc_cidr" {

  description = "VPC CIDR block"

  type = string

}


variable "availability_zones" {

  description = "Availability zones"

  type = list(string)

}


variable "db_username" {

  description = "Database username"

  type = string

  sensitive = true

}


variable "db_password" {

  description = "Database password"

  type = string

  sensitive = true

}