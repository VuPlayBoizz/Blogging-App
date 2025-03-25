variable "vpc_id" {
    description = "The VPC ID"
    type        = string
}

variable "lb_target_group_name" {
    description = "The name of the target group"
    type        = string
}

variable "lb_target_group_port" {
    description = "The port the target group is listening on"
    type        = number
}

variable "lb_target_group_protocol" {
    description = "The protocol the target group is using"
    type        = string
}

variable "ec2_instance_id" {
    description = "The ID of the EC2 instance to attach to the target group"
    type        = string
}