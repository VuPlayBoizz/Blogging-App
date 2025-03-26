terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.84.0"
        }
    }
}

provider "aws" {
    region = "ap-southeast-1"
}


# Sử dụng data để lấy thông tin của các VPC có sẵn
data "aws_vpc" "eks_vpc" {
    filter {
        name   = "tag:Name"
        values = ["eks-vpc"]
    }
}

data "aws_vpc" "jenkins_vpc" {
    filter {
        name   = "tag:Name"
        values = ["jenkins-vpc"]
    }
}

data "aws_vpc" "database_vpc" {
    filter {
        name   = "tag:Name"
        values = ["database-vpc"]
    }
}

# Lấy danh sách tất cả private subnets của từng VPC theo naming convention
data "aws_subnets" "eks_private_subnets" {
    filter {
        name   = "vpc-id"
        values = [data.aws_vpc.eks_vpc.id]
    }

    filter {
        name   = "tag:Name"
        values = ["eks-vpc-private-subnet-*"]  # Lấy tất cả subnet có tiền tố này
    }
}

data "aws_subnets" "jenkins_private_subnets" {
    filter {
        name   = "vpc-id"
        values = [data.aws_vpc.jenkins_vpc.id]
    }

    filter {
        name   = "tag:Name"
        values = ["jenkins-vpc-private-subnet-*"]
    }
  }

data "aws_subnets" "database_private_subnets" {
    filter {
        name   = "vpc-id"
        values = [data.aws_vpc.database_vpc.id]
    }

    filter {
        name   = "tag:Name"
        values = ["database-vpc-private-subnet-*"]
    }
}

# Lấy thông tin route tables của từng VPC (Chỉ lấy route tables của private subnets)
data "aws_route_table" "eks_private_rtb" {
    vpc_id = data.aws_vpc.eks_vpc.id
    filter {
        name   = "tag:Name"
        values = ["eks-vpc-private-rtb"]
    }
}

data "aws_route_table" "jenkins_private_rtb" {
    vpc_id = data.aws_vpc.jenkins_vpc.id
    filter {
        name   = "tag:Name"
        values = ["jenkins-vpc-private-rtb"]
    }
}

data "aws_route_table" "database_private_rtb" {
    vpc_id = data.aws_vpc.database_vpc.id
    filter {
        name   = "tag:Name"
        values = ["database-vpc-private-rtb"]
    }
}
