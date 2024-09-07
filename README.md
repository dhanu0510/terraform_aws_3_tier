# 3-Tier Architecture with Terraform

### Overview

This project creates a fully automated 3-tier architecture in AWS using Terraform. It includes a Virtual Private Cloud (VPC) that spans two Availability Zones (AZs), public and private subnets, a database subnet, two NAT Gateways, an Application Load Balancer (ALB), and a database. The infrastructure is built in a single AWS region, following best practices for high availability and fault tolerance.

### Architecture Components:

1. VPC: A custom Virtual Private Cloud that spans across two Availability Zones.
2. Subnets:
   - Public Subnets: For internet-facing resources like the ALB.
   - Private Subnets: For backend application servers.
   - DB Subnets: For the RDS instance, isolated for security.
3. NAT Gateways: One per AZ, to allow private subnets to access the internet for updates.
4. Application Load Balancer (ALB): Distributes traffic to application servers across multiple AZs.
5. Database (RDS): A managed database in the isolated DB subnet for secure access.
6. Security Groups: For controlling inbound and outbound traffic to resources.
7. Route Tables: For routing traffic between subnets and to the internet.

### Prerequisites

1. AWS Account: To create resources in AWS.
2. Terraform: To define and provision the infrastructure.
3. AWS CLI: To configure AWS credentials for Terraform. or you can use AWS IAM Role to provide access to Terraform.

### Project Structure

```
3-tier-architecture/
├── modules/
│   ├── alb/
│   ├── asg/
│   ├── key/
│   ├── nat/
│   ├── rds/
│   ├── sg/
│   └── vpc/
├── terraform/
│   ├── main.tf
│   ├── backend.tf
│   ├── variables.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── outputs.tf
└── README.md
```

### Usage

1. Clone the repository:

```bash
git clone "https://github.com/dhanu0510/terraform_aws_3_tier.git"
cd terraform_aws_3_tier
```

2. Initialize the Terraform configuration:

```bash
cd terraform
terraform init
```

3. Setup AWS CLI or add AWS credentials to `provider.tf`:

```hcl
provider "aws" {
  region = "us-east
    access_key
    secret_key
}
```

4. Modify the `terraform.tfvars` file with your settings or leave it as default:

5. Plan and Apply the Terraform configuration:

```bash
terraform plan
terraform apply
```

### Accessing the Application

1. Get the ALB DNS name from the Terraform output:

```bash
terraform output alb_dns_name
```

2. Open the ALB DNS name in a web browser to access the application.

### Clean Up

1. Destroy the Terraform resources:

```bash
terraform destroy
```
