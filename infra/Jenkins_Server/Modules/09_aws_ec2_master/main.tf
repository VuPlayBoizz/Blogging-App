data "aws_ami" "ubuntu_ami" {
    most_recent = true
    owners      = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }
}

resource "aws_instance" "ec2_instance" {
    ami                         = data.aws_ami.ubuntu_ami.id # Ubuntu Server 24.04 LTS (x86)
    instance_type               = var.instance_type
    key_name                    = var.key_name
    subnet_id                   = var.subnet_id
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = [var.security_groups_id]
    root_block_device {
        volume_size = 20
        volume_type = "gp3"
    }

    connection {
        type        = "ssh"
        user        = "ubuntu"  # Thường là "ubuntu" hoặc "ec2-user" tùy vào AMI
        private_key = file(var.private_key_path)  # Đảm bảo bạn đã đặt đúng key
        host        = self.public_ip
    }

    # Tạo thư mục trước khi upload file
    provisioner "remote-exec" {
        inline = [
            "sudo mkdir -p ${var.workspace_path}",
            "sudo chown ubuntu:ubuntu ${var.workspace_path}",
            "sudo chmod -R 755  ${var.workspace_path}"
        ]
    }

    # Sau khi thư mục đã tồn tại, upload file
    provisioner "file" {
        source      = "./Modules/09_aws_ec2_master/install/${var.script_name}"
        destination = "${var.workspace_path}/${var.script_name}"
    }

    # Cấp quyền thực thi và chạy script
    provisioner "remote-exec" {
        inline = [
            "sudo chmod +x ${var.workspace_path}/${var.script_name}",
            "sudo ${var.workspace_path}/${var.script_name}"
        ]
    }

    tags = {
        Name = var.name
    }
}
