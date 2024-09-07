project_name = "3-tier-app"
region       = "ca-central-1"

# VPC
vpc_cidr                = "10.16.0.0/16"
public_subnet_1a_cidr   = "10.16.16.0/24"
public_subnet_1b_cidr   = "10.16.17.0/24"
private_subnet_1a_cidr  = "10.16.18.0/24"
private_subnet_1b_cidr  = "10.16.19.0/24"
database_subnet_1a_cidr = "10.16.20.0/24"
database_subnet_1b_cidr = "10.16.21.0/24"

# Key Pair
key_name        = "3-tier-app-key"
public_key_path = "../ssh_key/3_tier.pub"

# ASG : Auto Scaling Group
instance_type = "t2.micro"
image_id      = "ami-0c6d358ee9e264ff1" # ubuntu 24.04

# RDS : Relational Database Service
username = "admin"
password = "password"
