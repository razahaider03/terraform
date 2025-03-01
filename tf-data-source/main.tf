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

data "aws_region" "aws-region" {
  
}

data "aws_availability_zones" "aws_availability_zones" {
  state = "available"
}

data "aws_vpc" "vpc-id" {
  
}

data "aws_region" "current" {}

data "aws_service" "test" {
  region     = data.aws_region.current.name
  service_id = "ec2"
}

# data "aws_s3_bucket" "s3_data" {
#   bucket = 
# }

output "test" {
  value = data.aws_service.test
}

output "aws-region" {
  value = data.aws_region.aws-region
  
}

output "aws-AZ" {
  value = data.aws_availability_zones.aws_availability_zones
}

output "vpc" {
  value = data.aws_vpc.vpc-id.id
}