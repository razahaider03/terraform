terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
  backend "s3" {
    bucket = "myubucket-92e8a432"
    region = "ap-south-1"
    key = "backend.tfstate"
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "backend-s3-demo" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = "t3.nano"
  subnet_id = "subnet-03e3ffa7bd38de3ea"
  tags = {
    Name = "SampleServer"
  }
}

output "name" {
  value = aws_instance.backend-s3-demo.public_ip
}
