output "aws_lb_dns_name" {
    value = aws_lb.jenkins_loadbalancer.dns_name
}

output "aws_lb_zone_id" {
    value = aws_lb.jenkins_loadbalancer.zone_id
}
