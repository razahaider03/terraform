terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "data-EC2" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = var.aws_instance_type
  root_block_device {
    delete_on_termination = true
    volume_size = var.EC2-config.v_size
    volume_type = var.EC2-config.v_type
  }


  subnet_id = data.aws_subnet.subnet.id
  security_groups = [ data.aws_security_group.aws_sg.id ]

  tags = merge(var.additional_tags, {
    Name = "My_Server"
  })
}








data "aws_vpc" "VPC" {
  
}

data "aws_subnet" "subnet" {
  vpc_id = data.aws_vpc.VPC.id
}

data "aws_security_group" "aws_sg" {
  vpc_id = data.aws_vpc.VPC.id
}

# output "subnet" {
#   value = data.aws_subnet.subnet
# }

