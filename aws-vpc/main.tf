terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.87.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.6.3"
    # }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "tf_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_subnet" "tf-pub-subnet" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "172.16.1.0/24"
  tags = {
    Name = "tf-pub-subnet"
  }
}

resource "aws_subnet" "tf-pvt-subnet" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = "172.16.2.0/24"
  tags = {
    Name = "tf-pvt-subnet"
  }
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "tf-igw"
  }
}

resource "aws_route_table" "tf-pub-route" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }
  tags = {
    Name = "tf-pub-route"
  }
}

resource "aws_route_table_association" "tf-rt-ass" {
  route_table_id = aws_route_table.tf-pub-route.id
  subnet_id = aws_subnet.tf-pub-subnet.id
}

