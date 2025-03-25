variable "rds_subnet_group_name" {
  description = "The name for the RDS subnet group"
  type        = string
}

variable "description" {
  description = "Description for the subnet group"
  type        = string
  default     = "RDS subnet group created by Terraform"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs to include in the subnet group"
  type        = list(string)
}
