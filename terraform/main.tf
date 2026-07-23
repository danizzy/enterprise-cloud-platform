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