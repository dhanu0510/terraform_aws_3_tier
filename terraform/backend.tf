terraform {
  backend "s3" {
    bucket         = "dhanu0510-terraform-aws-3-tier"
    key            = "backend/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "terraform-aws-3-tier"
  }
}

# dynamodb_table
# Partition key: LockID (string) 
