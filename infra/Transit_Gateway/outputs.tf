# outputs.tf
output "transit_gateway_id" {
  description = "ID của AWS Transit Gateway"
  value       = aws_ec2_transit_gateway.tgw.id
}

output "eks_vpc_id" {
  description = "ID của eks-vpc"
  value       = data.aws_vpc.eks_vpc.id
}

output "jenkins_vpc_id" {
  description = "ID của jenkins-vpc"
  value       = data.aws_vpc.jenkins_vpc.id
}

output "ec2_instance_vpc_id" {
  description = "ID của ec2-instance-vpc"
  value       = data.aws_vpc.ec2_instance_vpc.id
}