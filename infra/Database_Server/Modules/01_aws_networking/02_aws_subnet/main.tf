# Setup public subnet
resource "aws_subnet" "public_subnets" {
    vpc_id            = var.vpc_id    
    count             = length(var.cidr_public_subnet)
    cidr_block        = element(var.cidr_public_subnet, count.index)
    availability_zone = element(var.availability_zone, count.index)
    map_public_ip_on_launch = true

    tags                    = merge(var.tags, { Name = "${var.tags["Name"]}-public-subnet-${element(var.availability_zone, count.index)}"})
}

# Setup private subnet
resource "aws_subnet" "private_subnets" {
    vpc_id            = var.vpc_id    
    count             = length(var.cidr_private_subnet)
    cidr_block        = element(var.cidr_private_subnet, count.index)
    availability_zone = element(var.availability_zone, count.index)

    tags                    = merge(var.tags, { Name = "${var.tags["Name"]}-private-subnet-${element(var.availability_zone, count.index)}"})
}