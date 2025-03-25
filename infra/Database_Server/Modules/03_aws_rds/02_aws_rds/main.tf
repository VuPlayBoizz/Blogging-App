resource "aws_db_instance" "rds_database" {
    identifier              = var.db_identifier
    db_name                 = var.db_name
    engine                  = var.engine
    engine_version          = var.engine_version
    instance_class          = var.instance_class

    allocated_storage       = var.allocated_storage
    storage_type            = var.storage_type
    multi_az                = var.multi_az
    publicly_accessible     = var.publicly_accessible

    username                = var.username
    password                = var.password
    parameter_group_name    = var.parameter_group_name
    
    db_subnet_group_name    = var.subnet_group_name
    vpc_security_group_ids  = var.vpc_security_group_ids

    storage_encrypted           = true
    auto_minor_version_upgrade  = true
    skip_final_snapshot         = true

    tags                    = var.tags
}