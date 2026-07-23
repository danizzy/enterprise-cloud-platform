module "networking" {

  source = "./modules/networking"


  project_name = var.project_name

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

}

module "security" {

  source = "./modules/security"


  project_name = var.project_name


  environment = var.environment


  vpc_id = module.networking.vpc_id

}

module "ecr" {

  source = "./modules/ecr"


  project_name = var.project_name


  environment = var.environment

}

module "alb" {

  source = "./modules/alb"


  project_name = var.project_name


  environment = var.environment


  vpc_id = module.networking.vpc_id


  public_subnets = module.networking.public_subnets


  security_group_id = module.security.alb_security_group_id

}

module "rds" {

  source = "./modules/rds"


  project_name = var.project_name


  environment = var.environment



  private_subnets = module.networking.private_subnets



  database_security_group_id = module.security.database_security_group_id



  db_username = var.db_username



  db_password = var.db_password

}

module "ecs" {

  source = "./modules/ecs"



  project_name = var.project_name



  environment = var.environment



  private_subnets = module.networking.private_subnets



  ecs_security_group_id = module.security.ecs_security_group_id



  execution_role_arn = module.security.ecs_execution_role_arn



  task_role_arn = module.security.ecs_task_role_arn



  target_group_arn = module.alb.target_group_arn



  container_image = "${module.ecr.repository_url}:latest"



  database_secret_arn = module.secrets.database_secret_arn



  container_port = 3000

}

module "secrets" {

  source = "./modules/secrets"


  project_name = var.project_name


  environment = var.environment


  db_username = var.db_username


  db_password = var.db_password

}