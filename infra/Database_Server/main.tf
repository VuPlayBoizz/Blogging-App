module "aws-vpc" {
    source                  = "./Modules/01_aws_networking/01_aws_vpc"
    cidr_block              = var.cidr_block
    enable_dns_hostnames    = var.enable_dns_hostnames
    enable_dns_support      = var.enable_dns_support

    tags                    = var.tags
}

module "aws-subnet" {
    source                  = "./Modules/01_aws_networking/02_aws_subnet"
    vpc_id                  = module.aws-vpc.vpc_id
    cidr_public_subnet      = var.cidr_public_subnet
    cidr_private_subnet     = var.cidr_private_subnet
    availability_zone       = var.availability_zone
    
    tags                    = var.tags
}

module "aws-igw" {
    source                  = "./Modules/01_aws_networking/03_aws_internet_gateway"
    vpc_id                  = module.aws-vpc.vpc_id
    
    tags                    = var.tags
}

module "aws-route-table" {
    source                  = "./Modules/01_aws_networking/04_aws_route_tables"
    vpc_id                  = module.aws-vpc.vpc_id
    internet_gateway_id     = module.aws-igw.internet_gateway_id
    public_subnet_ids       = module.aws-subnet.public_subnet_ids
    private_subnet_ids      = module.aws-subnet.private_subnet_ids
    
    tags                    = var.tags
}

module "aws-security-group" {
    source                  = "./Modules/01_aws_networking/05_aws_security_groups"
    vpc_id                  = module.aws-vpc.vpc_id
    My_computer_ip          = var.My_computer_ip
    
    tags                    = var.tags
}

module "aws-key-pair" {
    source                  = "./Modules/02_aws_ec2/01_aws_key_pair"
    key_name                = var.key_name  
}

module "application-server" {
    source                      = "./Modules/02_aws_ec2/02_server"
    instance_type               = var.instance_type
    key_name                    = module.aws-key-pair.key_name
    subnet_id                   = module.aws-subnet.public_subnet_ids[0]
    security_groups_id          = [module.aws-security-group.ec2_security_group_id,
                                   module.aws-security-group.app_security_group_id]
    script_name                 = var.script_name
    name                        = "App-Server"
    associate_public_ip_address = true 
}

module "aws-instance-target-group" {
    source                      = "./Modules/03_aws_loadbalancer/01_aws_target_groups"
    vpc_id                      = module.aws-vpc.vpc_id
    ec2_instance_id             = module.application-server.master_instance_id   
    lb_target_group_name        = var.lb_target_group_name
    lb_target_group_port        = var.lb_target_group_port
    lb_target_group_protocol    = var.lb_target_group_protocol
}

module "application-loadbalancer" {
    source                      = "./Modules/03_aws_loadbalancer/02_application_loadbalancer"
    lb_name                     = var.lb_name
    is_external                 = var.is_external
    lb_type                     = var.lb_type
    sg_enable_ssh_https         = module.aws-security-group.ec2_security_group_id
    subnet_ids                  = module.aws-subnet.public_subnet_ids
    
    lb_listner_port             = var.lb_listner_port
    lb_listner_protocol         = var.lb_listner_protocol
    lb_listner_default_action   = var.lb_listner_default_action
    
    lb_target_group_arn         = module.aws-instance-target-group.instance_target_group_arn
    ec2_instance_id             = module.application-server.master_instance_id
    
    lb_https_listner_port           = var.lb_https_listner_port
    lb_https_listner_protocol       = var.lb_https_listner_protocol
    devops_project_acm_arn          = module.aws_ceritification_manager.certificate_arn
    lb_target_group_attachment_port = var.lb_target_group_attachment_port
    tags                            = var.tags
}

module "aws_ceritification_manager" {
    source                          = "./Modules/04_certificate_manager"
    certificate_domain_name         = var.certificate_domain_name
    certificate_validation_method   = var.certificate_validation_method
    route53_zone_id                 = module.hosted_zone.hosted_zone_id
    tags                            = var.tags
}

module "hosted_zone" {
    source          = "./Modules/05_route_53/01_hosted_zones"
    name_of_dns     = var.name_of_dns
    domain_name     = var.domain_name
    aws_lb_dns_name = module.application-loadbalancer.aws_lb_dns_name
    aws_lb_zone_id  = module.application-loadbalancer.aws_lb_zone_id
}

module "rds-subnet-group" {
    source                  = "./Modules/06_aws_rds/01_aws_rds_subnet_groups"
    private_subnet_ids      = module.aws-subnet.private_subnet_ids
    rds_subnet_group_name   = "rds-subnet-group"
}

module "rds-database" {
    source                      = "./Modules/06_aws_rds/02_aws_rds"
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
    vpc_security_group_ids      = [module.aws-security-group.rds_mysql_security_group_id]

    depends_on                  = [module.rds-subnet-group]
    tags                        = var.tags
}



