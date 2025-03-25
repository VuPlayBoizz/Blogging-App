resource "aws_security_group" "ec2_security_group" {
    name        = "ec2_security_group"
    vpc_id      = var.vpc_id
    description = "Enable the Port 22(SSH) & Port 80(http)"

    ingress {
        description = "Allow SSH from my computer IP"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.My_computer_ip]
    }

    ingress {
        description = "Allow HTTP request from my computer ip"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow HTTPS request from my computer ip"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Allow all traffic from 0.0.0.0/0"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(var.tags, {Name: "ec2_security_group"})   
}

resource "aws_security_group" "rds_mysql_security_group" {
    name        = "rds_mysql_security_group"
    vpc_id      = var.vpc_id
    description = "Allow access to RDS from EC2 present in public subnet"

    ingress {
        description = "Allow 3306 port to access rds_mysql"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  

    egress {
        description = "Allow all traffic from 0.0.0.0/0"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(var.tags, {Name: "rds_mysql_security_group"})   
}

resource "aws_security_group" "app_security_group" {
    name        = "app_security_group"
    vpc_id      = var.vpc_id
    description = "Enable the Port 5000 for python api"

    ingress {
        description = "Allow traffic on port 5000"
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  
    
    tags = merge(var.tags, {Name: "app_security_group"})   
}
