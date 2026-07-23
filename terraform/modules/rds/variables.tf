variable "project_name" {

  type = string

}


variable "environment" {

  type = string

}


variable "private_subnets" {

  type = list(string)

}


variable "database_security_group_id" {

  type = string

}


variable "db_username" {

  type = string

  sensitive = true

}


variable "db_password" {

  type = string

  sensitive = true

}