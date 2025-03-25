variable "vpc_id" {
    description = "The VPC ID"
    type        = string
}

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

variable "tags" {
    description = "The tags for the subnet"
    type        = map(string)
}
