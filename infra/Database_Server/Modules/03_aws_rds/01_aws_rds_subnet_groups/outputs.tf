output "rds_subnet_group_id" {
    value = aws_db_subnet_group.rds_subnet_group.id
}
output "rds_subnet_group_name" {
    value = aws_db_subnet_group.rds_subnet_group.name 
}