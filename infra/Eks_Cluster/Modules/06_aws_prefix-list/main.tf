resource "aws_ec2_managed_prefix_list" "eks_prefix_list" {
  name        = "eks_vpc_prefix_list"
  address_family = "IPv4"
  max_entries = 5

  entry {
    cidr        = var.eks_vpc_cidr
    description = "CIDR for eks vpc cidr"
  }

  entry {
    cidr        = var.jenkins_vpc_cidr
    description = "CIDR for jenkins vpc cidr"
  }

  entry {
    cidr = var.ec2_vpc_cidr
    description = "CIDR for ec2 vpc cidr"
  }

  entry {
    cidr        = var.My_computer_ip
    description = "CIDR for My IP address"
  }


}