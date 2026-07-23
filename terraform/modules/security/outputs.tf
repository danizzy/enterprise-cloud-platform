output "alb_security_group_id" {

  value = aws_security_group.alb.id

}


output "ecs_security_group_id" {

  value = aws_security_group.ecs.id

}


output "database_security_group_id" {

  value = aws_security_group.database.id

}


output "ecs_execution_role_arn" {

  value = aws_iam_role.ecs_execution.arn

}


output "ecs_task_role_arn" {

  value = aws_iam_role.ecs_task.arn

}