output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}

output "client_security_group_id" {
  value = aws_security_group.client_security_group.id
}

output "db_security_group_id" {
  value = aws_security_group.db_security_group.id
}
