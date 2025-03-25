//Define tags name
variable "tags" {
    description = "A map of tags to assign to the resources"
    type        = map(string)
}

//Define the variables Provider
variable "region" {
    description = "The AWS region to deploy to"
    type = string
}

// Define the variables for the aws_vpc module
variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
}
variable "enable_dns_support" {
    description = "A boolean flag to enable/disable DNS support in the VPC"
    type        = bool
}
variable "enable_dns_hostnames" {
    description = "A boolean flag to enable/disable DNS hostnames in the VPC"
    type        = bool
}

// Define the variables for the aws_subnet module
variable "cidr_public_subnet" {
    description = "The CIDR block for the public subnet"
    type        = list(string)
}
variable "cidr_private_subnet" {
    description = "The CIDR block for the private subnet"
    type        = list(string)
}
variable "availability_zone" {
    description = "The availability zone"
    type        = list(string)
}

// Define the variables in aws_igw module
// Define the variables in aws_route_tables module
// Define the variables in aws_security_groups module
variable "My_computer_ip" {
    description = "The IP address of the computer"
    type        = string
}

//Define the aws_key_pair variable
variable "key_name" {
    description = "Name of the key pair"
    type        = string
}

//Define the variables in aws_jenkins_master module
variable "instance_type" {
    description = "The instance type to use"
    type        = string
}
variable "script_name" {
    description = "The name of the script to run"
    type        = string
}

//Define the variables in aws_target_groups module
variable "lb_target_group_name" {
    description = "The name for the target group"
    type        = string
}
variable "lb_target_group_port" {
    description = "The port for the target group"
    type        = number
}
variable "lb_target_group_protocol" {
    description = "The protocol for the target group"
    type        = string
}

//Define the variables in aws_loadbalancer module
variable "lb_name" {
    description = "The name of the Load Balancer"
    type        = string
}
variable "lb_type" {
    description = "The type of the Load Balancer"
    type        = string
}
variable "is_external" {
    description = "A boolean flag to specify if the Load Balancer is external or internal"
    type        = bool
}
variable "lb_listner_port" {
    description = "The port for the Load Balancer listener"
    type        = number
}
variable "lb_listner_protocol" {
    description = "The port for the Load Balancer listener"
    type        = string
}
variable "lb_listner_default_action" {
    description = "The default action for the Load Balancer listener"
    type        = string
}
variable "lb_https_listner_port" {
    description = "The port for the Load Balancer listener"
    type        = number
}
variable "lb_https_listner_protocol" {
    description = "The port for the Load Balancer listener"
    type        = string
}
variable "lb_target_group_attachment_port" {
    description = "The port for the Load Balancer listener"
    type        = number
}

//Define the variables in aws_certificate_manager module
variable "certificate_domain_name" {
    description = "Tên miền cho chứng chỉ SSL"
    type        = string
}

variable "certificate_validation_method" {
    description = "Phương thức xác minh chứng chỉ (DNS hoặc EMAIL)"
    type        = string
}

//Define the variables in aws_route53 module
variable "name_of_dns" {
  description = "Tên miền của Hosted Zone"
  type        = string
}

variable "domain_name" {
  description = "Tên miền để tạo bản ghi A"
  type        = string
}

// Define the variables in aws_rds module
variable "db_identifier" {
  description = "The DB instance identifier"
  type        = string
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "engine" {
  description = "Database engine type"
  type        = string
}

variable "engine_version" {
  description = "Engine Version"
  type        = string
}

variable "instance_class" {
  description = "RDS Instance Class"
  type        = string
}

variable "allocated_storage" {
  description = "Size in GB"
  type        = number
}

variable "storage_type" {
  description = "Storage type: standard, gp2, gp3, io1"
  type        = string
}

variable "multi_az" {
  description = "Enable multi AZ for high availability"
  type        = bool
}

variable "publicly_accessible" {
  description = "Expose the database publicly (true/false)"
  type        = bool
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group to associate"
  type        = string
}