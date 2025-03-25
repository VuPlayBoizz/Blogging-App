variable "route53_zone_id" {
  description = "ID của Hosted Zone trong Route 53"
  type        = string
}

variable "certificate_domain_name" {
    description = "Tên miền cho chứng chỉ SSL"
    type        = string
}

variable "certificate_validation_method" {
    description = "Phương thức xác minh chứng chỉ (DNS hoặc EMAIL)"
    type        = string
}

variable "tags" {
    description = "Tags cho chứng chỉ SSL"
    type        = map(string)
}
