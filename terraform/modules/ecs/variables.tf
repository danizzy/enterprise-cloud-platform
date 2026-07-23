variable "project_name" {

  type = string

}


variable "environment" {

  type = string

}


variable "private_subnets" {

  type = list(string)

}


variable "ecs_security_group_id" {

  type = string

}


variable "execution_role_arn" {

  type = string

}


variable "task_role_arn" {

  type = string

}


variable "target_group_arn" {

  type = string

}


variable "container_image" {

  type = string

}


variable "container_port" {

  type = number

}

variable "database_secret_arn" {

  type = string

}