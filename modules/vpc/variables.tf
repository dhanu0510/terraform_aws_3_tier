variable "project_name" {}

variable "vpc_cidr" {}

# for public subnets (presentation layer)
variable "public_subnet_1a_cidr" {}
variable "public_subnet_1b_cidr" {}

# for private subnets (application layer)
variable "private_subnet_1a_cidr" {}
variable "private_subnet_1b_cidr" {}

# for database subnets (data layer)
variable "database_subnet_1a_cidr" {}
variable "database_subnet_1b_cidr" {}
