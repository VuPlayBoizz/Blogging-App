output "certificate_arn" {
  description = "ARN của chứng chỉ SSL ACM"
  value       = aws_acm_certificate.devops_project_acm_certificate.arn
}
