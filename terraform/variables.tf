variable "project_name" {}

variable "region" {}

# VPC
variable "vpc_cidr" {}

## for public subnets (presentation layer)
variable "public_subnet_1a_cidr" {}
variable "public_subnet_1b_cidr" {}

## for private subnets (application layer)
variable "private_subnet_1a_cidr" {}
variable "private_subnet_1b_cidr" {}

## for database subnets (data layer)
variable "database_subnet_1a_cidr" {}
variable "database_subnet_1b_cidr" {}


# Key Pair
variable "key_name" {}
variable "public_key_path" {}

# ASG : Auto Scaling Group
variable "instance_type" {}
variable "image_id" {}

# RDS : Relational Database Service
variable "username" {}
variable "password" {}
