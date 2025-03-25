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

variable "vpc_security_group_ids" {
  description = "List of VPC Security Group IDs"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "The subnet group name to launch the instance in"
  type        = string
}

variable "tags" {
    description = "A map of tags to assign to the resource"
    type        = map(string)
}
