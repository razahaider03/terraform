resource "aws_security_group" "nginx-sg" {
  vpc_id = aws_vpc.tf_vpc.id

  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
    protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    "Name" = "nginx-sg"
  }
}