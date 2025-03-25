module "vpc" {
    source = "./Modules/01_aws_networking/01_aws_vpc"
    cidr_block              = var.cidr_block
    enable_dns_hostnames    = var.enable_dns_hostnames
    enable_dns_support      = var.enable_dns_support
    tags                    = var.tags
}

module "vpc-subnet-1a" {
    source                      = "./Modules/01_aws_networking/02_aws_subnet"
    vpc_id                      = module.vpc.vpc_id
    public_subnet_cidr_block    = var.public_subnet_cidr_block[0]
    private_subnet_cidr_block   = var.private_subnet_cidr_block[0]
    availability_zone           = var.availability_zone[0]
    tags                        = var.tags
}

module "vpc-subnet-1b" {
    source                      = "./Modules/01_aws_networking/02_aws_subnet"
    vpc_id                      = module.vpc.vpc_id
    public_subnet_cidr_block    = var.public_subnet_cidr_block[1]
    private_subnet_cidr_block   = var.private_subnet_cidr_block[1]
    availability_zone           = var.availability_zone[1]
    tags                        = var.tags
}

module "vpc-igw" {
    source      = "./Modules/01_aws_networking/03_aws_igw"
    vpc_id      = module.vpc.vpc_id
    tags        = var.tags
}

module "vpc-route-table" {
    source              = "./Modules/01_aws_networking/04_aws_route_tables"
    vpc_id              = module.vpc.vpc_id
    internet_gateway_id = module.vpc-igw.internet_gateway_id
    public_subnet_ids   = [module.vpc-subnet-1a.public_subnet_id, module.vpc-subnet-1b.public_subnet_id]  
    private_subnet_ids  = [module.vpc-subnet-1a.private_subnet_id, module.vpc-subnet-1b.private_subnet_id]
    tags                = var.tags
}

module "vpc-security-group" {
    source                      = "./Modules/01_aws_networking/05_aws_security_groups"
    vpc_id                      = module.vpc.vpc_id    
    My_computer_ip              = var.My_computer_ip
    tags                        = var.tags 
}

module "key-pair" {
    source      = "./Modules/02_aws_ec2/06_aws_key_pair"
    key_name = var.key_name 
}

module "ec2-instance" {
    source                      = "./Modules/02_aws_ec2/07_aws_ec2"
    instance_type               = var.instance_type
    key_name                    = module.key-pair.key_name
    subnet_id                   = module.vpc-subnet-1a.public_subnet_id
    security_groups_id          = [module.vpc-security-group.jumpserver_sg_id]
    associate_public_ip_address = true
    name                        = "JumpServer"
}

module "rds-subnet-group" {
    source                  = "./Modules/03_aws_rds/08_aws_rds_subnet_groups"
    private_subnet_ids      = [module.vpc-subnet-1a.private_subnet_id, 
                               module.vpc-subnet-1b.private_subnet_id]
    rds_subnet_group_name   = "rds-subnet-group"
}

module "rds-database" {
    source                      = "./Modules/03_aws_rds/09_aws_rds"
    db_identifier               = var.db_identifier
    db_name                     = var.db_name
    engine                      = var.engine
    engine_version              = var.engine_version
    instance_class              = var.instance_class

    allocated_storage           = var.allocated_storage
    storage_type                = var.storage_type
    multi_az                    = var.multi_az
    publicly_accessible         = var.publicly_accessible

    username                    = var.username
    password                    = var.password
    parameter_group_name        = var.parameter_group_name

    subnet_group_name           = module.rds-subnet-group.rds_subnet_group_name
    vpc_security_group_ids      = [module.vpc-security-group.rds_sg_id]

    depends_on                  = [module.rds-subnet-group]
    tags                        = var.tags
}

