provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "nginxserver" {
  ami                         = "ami-0d682f26195e9ec0f"
  instance_type               = "t3.nano"
  subnet_id                   = aws_subnet.tf-pub-subnet.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.nginx-sg.id]

  user_data = <<-EOF
            #!/bin/bash
            sudo yum install nginx -y
            sudo systemctl start nginx
            EOF
  tags = {
    Name = "NginxServer"
  }
}
