module "vpc" {
  source                  = "../modules/vpc"
  project_name            = var.project_name
  vpc_cidr                = var.vpc_cidr
  public_subnet_1a_cidr   = var.public_subnet_1a_cidr
  public_subnet_1b_cidr   = var.public_subnet_1b_cidr
  private_subnet_1a_cidr  = var.private_subnet_1a_cidr
  private_subnet_1b_cidr  = var.private_subnet_1b_cidr
  database_subnet_1a_cidr = var.database_subnet_1a_cidr
  database_subnet_1b_cidr = var.database_subnet_1b_cidr
}

module "nat" {
  source = "../modules/nat"

  project_name          = var.project_name
  public_subnet_1a_id   = module.vpc.public_subnet_1a_id
  public_subnet_1b_id   = module.vpc.public_subnet_1b_id
  private_subnet_1a_id  = module.vpc.private_subnet_1a_id
  private_subnet_1b_id  = module.vpc.private_subnet_1b_id
  database_subnet_1a_id = module.vpc.database_subnet_1a_id
  database_subnet_1b_id = module.vpc.database_subnet_1b_id
  igw_id                = module.vpc.igw_id
  vpc_id                = module.vpc.vpc_id
}

module "sg" {
  source = "../modules/sg"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "key_pair" {
  source = "../modules/key"

  key_name        = var.key_name
  public_key_path = var.public_key_path

}

module "alb" {
  source = "../modules/alb"

  project_name          = var.project_name
  alb_security_group_id = module.sg.alb_security_group_id
  vpc_id                = module.vpc.vpc_id
  public_subnet_1a_id   = module.vpc.public_subnet_1a_id
  public_subnet_1b_id   = module.vpc.public_subnet_1b_id
  private_subnet_1a_id  = module.vpc.private_subnet_1a_id
  private_subnet_1b_id  = module.vpc.private_subnet_1b_id
  database_subnet_1a_id = module.vpc.database_subnet_1a_id
  database_subnet_1b_id = module.vpc.database_subnet_1b_id
}

module "asg" {
  source = "../modules/asg"

  project_name             = var.project_name
  instance_type            = var.instance_type
  image_id                 = var.image_id
  key_name                 = var.key_name
  client_security_group_id = module.sg.client_security_group_id
  private_subnet_1a_id     = module.vpc.private_subnet_1a_id
  private_subnet_1b_id     = module.vpc.private_subnet_1b_id
  target_group_arn         = module.alb.target_group_arn

}

module "rds" {
  source = "../modules/rds"

  project_name          = var.project_name
  db_security_group_id  = module.sg.db_security_group_id
  database_subnet_1a_id = module.vpc.database_subnet_1a_id
  database_subnet_1b_id = module.vpc.database_subnet_1b_id
  username              = var.username
  password              = var.password
}
