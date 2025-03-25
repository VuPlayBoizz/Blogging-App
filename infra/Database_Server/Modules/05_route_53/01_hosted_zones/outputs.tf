output "hosted_zone_id" {
  description = "ID của Hosted Zone trong Route 53"
  value       = data.aws_route53_zone.aws_domain.zone_id
}
