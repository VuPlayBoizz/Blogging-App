variable "vpc_id" {
    description = "The ID of the VPC where the security groups will be created"
    type        = string
}

variable "My_computer_ip" {
    description = "The IP address of the computer"
    type        = string
}

variable "tags" {
    description = "Tags to apply to the security groups"
    type        = map(string)
}