resource "aws_security_group" "jumpserver_sg" {
    name        = "jumpserver_sg"
    vpc_id      = var.vpc_id
    description = "This is security group for public subnet"
    ingress {
        description = "Allow SSH from my computer IP"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.My_computer_ip]
    }

    egress {
        description = "Allow all traffic from 0.0.0.0/0"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(var.tags, {Name: "public_sg"})   
}

resource "aws_security_group" "rds_sg" {
    name        = "rds_sg"
    vpc_id      = var.vpc_id
    description = "This is security group for rds"

    ingress {
        description = "Allow 3306 from my computer IP"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = [aws_security_group.jumpserver_sg.id]
    }

    ingress {
        description = "Allow 5432 from my computer IP"
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        security_groups = [aws_security_group.jumpserver_sg.id]
    } 

    ingress {
        description = "Allow 1521 from my computer IP"
        from_port   = 1521
        to_port     = 1521
        protocol    = "tcp"
        security_groups = [aws_security_group.jumpserver_sg.id]
    }

    ingress {
        description = "Allow 1433 from my computer IP"
        from_port   = 1433
        to_port     = 1433
        protocol    = "tcp"
        security_groups = [aws_security_group.jumpserver_sg.id]
    }

    ingress {
        description = "Allow 50000 from my computer IP"
        from_port   = 50000
        to_port     = 50000
        protocol    = "tcp"
        security_groups = [aws_security_group.jumpserver_sg.id]
    }   

    egress {
        description = "Allow all traffic from 0.0.0.0/0"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(var.tags, {Name: "rds_sg"})   
}

