# Create an Elastic IP for public subnet 1a
resource "aws_eip" "nat_eip_1a" {
  tags = {
    Name = "${var.project_name}-nat-eip-1a"
  }
}

# Create an Elastic IP for public subnet 1b
resource "aws_eip" "nat_eip_1b" {
  tags = {
    Name = "${var.project_name}-nat-eip-1b"
  }
}

# Create a NAT Gateway in public subnet 1a
resource "aws_nat_gateway" "nat_gateway_1a" {
  allocation_id = aws_eip.nat_eip_1a.id
  subnet_id     = var.public_subnet_1a_id

  tags = {
    Name = "${var.project_name}-nat-gateway-1a"
  }

  # Depends on the Internet Gateway: Explicitly state the dependency to ensure the NAT Gateway is created after the Internet Gateway
  depends_on = [
    var.igw_id
  ]
}

# Create a NAT Gateway in public subnet 1b
resource "aws_nat_gateway" "nat_gateway_1b" {
  allocation_id = aws_eip.nat_eip_1b.id
  subnet_id     = var.public_subnet_1b_id

  tags = {
    Name = "${var.project_name}-nat-gateway-1b"
  }

  # Depends on the Internet Gateway: Explicitly state the dependency to ensure the NAT Gateway is created after the Internet Gateway
  depends_on = [
    var.igw_id
  ]
}

# Create a Route Table for private subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1a.id
  }

  tags = {
    Name = "${var.project_name}-private-route-table"
  }
}

# Attach the private route table to private subnet 1a
resource "aws_route_table_association" "private_subnet_1a_association" {
  subnet_id      = var.private_subnet_1a_id
  route_table_id = aws_route_table.private_route_table.id
}

# Attach the private route table to private subnet 1b
resource "aws_route_table_association" "private_subnet_1b_association" {
  subnet_id      = var.private_subnet_1b_id
  route_table_id = aws_route_table.private_route_table.id
}

# Create a Route Table for database subnets
resource "aws_route_table" "database_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1b.id
  }


  tags = {
    Name = "${var.project_name}-database-route-table"
  }
}

# Attach the database route table to database subnet 1a
resource "aws_route_table_association" "database_subnet_1a_association" {
  subnet_id      = var.database_subnet_1a_id
  route_table_id = aws_route_table.database_route_table.id
}

# Attach the database route table to database subnet 1b
resource "aws_route_table_association" "database_subnet_1b_association" {
  subnet_id      = var.database_subnet_1b_id
  route_table_id = aws_route_table.database_route_table.id
}
