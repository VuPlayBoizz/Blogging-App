variable "instance_type" {
    type = string
}
variable "subnet_id" {
    type = string
}
variable "key_name" {
    type = string
}
variable "associate_public_ip_address" {
    type = bool
}
variable "security_groups_id" {
    type = list(string)
}
variable "name" {
    description = "The name of the EC2 instance"
    type        = string
}