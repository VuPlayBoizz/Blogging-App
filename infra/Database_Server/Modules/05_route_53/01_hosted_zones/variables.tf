variable "name_of_dns" {
  description = "Tên miền của Hosted Zone"
  type        = string
}

variable "domain_name" {
  description = "Tên miền để tạo bản ghi A"
  type        = string
}

variable "aws_lb_dns_name" {
  description = "DNS name của AWS Load Balancer"
  type        = string
}

variable "aws_lb_zone_id" {
  description = "Zone ID của AWS Load Balancer"
  type        = string
}
