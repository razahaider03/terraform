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
  instance_type = "t3.nano"
  subnet_id = data.aws_subnet.subnet.id
}

data "aws_subnet" "subnet" {
  vpc_id = data.aws_security_group.aws-sg.vpc_id
}
# data "aws_ami_ids" "ubuntu" {
#   owners = ["aws-marketplace"]

#   filter {
#     name   = "name"
#     values = ["Red Hat*"]
#   }
# }


data "aws_vpc" "vpc-id" {
  
}

data "aws_security_group" "aws-sg" {
  vpc_id = data.aws_vpc.vpc-id.id
}

output "vpc" {
  value = data.aws_vpc.vpc-id
}

output "aws-sg" {
  value = data.aws_security_group.aws-sg
}

output "aws-subnet" {
  value = data.aws_subnet.subnet
}
# output "AMI" {
#   value = data.aws_ami_ids.ubuntu
# }
