output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "igw_id" {
  value = aws_internet_gateway.internet_gateway.id
}

output "public_subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}
output "public_subnet_1b_id" {
  value = aws_subnet.public_subnet_1b.id
}
output "private_subnet_1a_id" {
  value = aws_subnet.private_subnet_1a.id
}
output "private_subnet_1b_id" {
  value = aws_subnet.private_subnet_1b.id
}
output "database_subnet_1a_id" {
  value = aws_subnet.database_subnet_1a.id
}
output "database_subnet_1b_id" {
  value = aws_subnet.database_subnet_1b.id
}
