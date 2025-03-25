resource "aws_ec2_transit_gateway" "tgw" {
    description                       = "Transit Gateway connecting eks-vpc, jenkins-vpc, and ec2-instance-vpc"
    amazon_side_asn                   = 64512
    auto_accept_shared_attachments    = "enable"
    default_route_table_association   = "enable"
    default_route_table_propagation   = "enable"
}
# Transit Gateway Attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "eks_tgw_attachment" {
    transit_gateway_id  = aws_ec2_transit_gateway.tgw.id
    vpc_id              = data.aws_vpc.eks_vpc.id
    subnet_ids          = data.aws_subnets.eks_private_subnets.ids
}

resource "aws_ec2_transit_gateway_vpc_attachment" "jenkins_tgw_attachment" {
    transit_gateway_id  = aws_ec2_transit_gateway.tgw.id
    vpc_id              = data.aws_vpc.jenkins_vpc.id
    subnet_ids          = data.aws_subnets.jenkins_private_subnets.ids
}

resource "aws_ec2_transit_gateway_vpc_attachment" "ec2_instance_tgw_attachment" {
    transit_gateway_id  = aws_ec2_transit_gateway.tgw.id
    vpc_id              = data.aws_vpc.ec2_instance_vpc.id
    subnet_ids          = data.aws_subnets.ec2_instance_private_subnets.ids
}

resource "aws_ec2_managed_prefix_list" "tgw_prefix_list" {
    name           = "tgw-prefix-list"
    address_family = "IPv4"
    max_entries    = 5 # Giới hạn số lượng CIDR có thể thêm

    entry {
        cidr        = "10.0.0.0/16"
        description = "Subnet 10.0.0.0/16"
    }

    entry {
        cidr        = "11.0.0.0/16"
        description = "Subnet 11.0.0.0/16"
    }

    entry {
        cidr        = "12.0.0.0/16"
        description = "Subnet 12.0.0.0/16"
    }

    tags = {
        Name = "TGW-Prefix-List"
    }
}

# Thêm route vào từng route table để gửi traffic qua Transit Gateway
resource "aws_route" "eks_to_tgw" {
  route_table_id         = data.aws_route_table.eks_private_rt.id
  destination_prefix_list_id = aws_ec2_managed_prefix_list.tgw_prefix_list.id
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "jenkins_to_tgw" {
  route_table_id         = data.aws_route_table.jenkins_private_rt.id
  destination_prefix_list_id = aws_ec2_managed_prefix_list.tgw_prefix_list.id
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

resource "aws_route" "ec2_instance_to_tgw" {
  route_table_id         = data.aws_route_table.ec2_instance_private_rt.id
  destination_prefix_list_id = aws_ec2_managed_prefix_list.tgw_prefix_list.id
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}