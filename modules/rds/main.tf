# Create db subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [var.database_subnet_1a_id, var.database_subnet_1b_id]
}

# Create a new RDS instance: mysql
resource "aws_db_instance" "mysql" {
  allocated_storage      = 20
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  username               = var.username
  password               = var.password
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.db_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  multi_az               = true
  deletion_protection    = false
  tags = {
    Name = "${var.project_name}-mysql"
  }

  depends_on = [aws_db_subnet_group.db_subnet_group]
}
