resource "aws_db_subnet_group" "rds_subnet_group" {
    name        = var.rds_subnet_group_name
    subnet_ids  = var.private_subnet_ids
    description = "RDS subnet group including private subnets"

    tags = {
        Name = var.rds_subnet_group_name
    }
}
