resource "aws_acm_certificate" "devops_project_acm_certificate" {
  domain_name       = var.certificate_domain_name
  validation_method = var.certificate_validation_method

  tags = merge(var.tags, {
    Name = "devops-project-acm-certificate"
  })
}

# Sử dụng `for_each` để xử lý các domain_validation_options
resource "aws_route53_record" "devops_project_acm_certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.devops_project_acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.route53_zone_id  # Cung cấp ID của Hosted Zone trong Route 53
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "devops_project_acm_certificate_validation" {
  certificate_arn = aws_acm_certificate.devops_project_acm_certificate.arn

  validation_record_fqdns = flatten([
    for record in aws_route53_record.devops_project_acm_certificate_validation : record.fqdn
  ])
}
